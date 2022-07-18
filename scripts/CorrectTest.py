from concurrent.futures import ThreadPoolExecutor
import datetime
from distutils.log import error
import subprocess
from time import time
import yaml
import re
import argparse
import time
import threading


class CorrectTest:
    def __init__(self, args):
        with open(args["file"], 'r') as config:
            threads_number = args["threads_number"]
            begin_time = datetime.datetime.now()
            yamlData = yaml.safe_load(config)
            self.teacher_file = yamlData["teacher_file"]
            self.test_questions = yamlData["test_questions"]
            self.student_files = yamlData["student_files"]
            self.teacher_result = self.test_file(self.teacher_file)
            self.students_results = {}
            # threads = []
            # for student_file in self.student_files:
            #     t = threading.Thread(
            #         target=self.assign_student_result, args=[student_file])
            #     t.start()
            #     threads.append(t)

            # for thread in threads:
            #     thread.join()

            with ThreadPoolExecutor(max_workers=threads_number) as executor:
                for student_file in self.student_files:
                    executor.submit(self.assign_student_result, student_file)

                # results = executor.map(
                #     self.assign_student_result, self.student_files)
                # print([result.result() for result in results])

            self.display_diff(self.teacher_result, self.students_results)
            print(self.students_results)
            print(
                f'{len(self.student_files)} files in {datetime.datetime.now() - begin_time}')

    def assign_student_result(self, student_file):
        print("file: ", student_file)
        prior_path, file_name_without_icl, ignore = self.get_student_name_from_path(
            student_file)
        self.students_results[file_name_without_icl] = self.test_file(
            student_file)
        # return self.test_file(student_file)

    def removeLastLineFromFile(self, file_path):
        with open(file_path, 'r+') as read_obj:
            fileContent = read_obj.readlines()
            fileContent = fileContent[:len(fileContent) - 1]
            read_obj.seek(0)
            for line in fileContent:
                read_obj.write(line)
            read_obj.truncate()

    def removeStartFromFile(self, file_path):
        with open(file_path, 'r+') as read_obj:
            fileContent = read_obj.readlines()
            read_obj.seek(0)
            for line in fileContent:
                if not re.search(r"(//)*( )*Start( )*=( )*", line):
                    read_obj.write(line)
            read_obj.truncate()

    def test_file(self, file_path):
        file_result = {}
        self.removeStartFromFile(file_path)
        prior_path, file_name_without_icl, ignore = self.get_student_name_from_path(file_path)
        pass_str = f"Compiling {file_name_without_icl}\nGenerating code for {file_name_without_icl}\nLinking {file_name_without_icl}"
        for index, question in enumerate(self.test_questions):
            function_name = question[f'q{index}']["function_name"]
            function_tests = {}
            for test in question[f'q{index}']["test_cases"]:
                with open(file_path, 'a') as write_obj:
                    write_obj.write(f'Start = {function_name} {test}\n')

                print("Imported ", f'Start = {function_name} {test}\n')
                command = f'clm -I  {prior_path} {file_name_without_icl} -o {file_name_without_icl}.out' if prior_path != "" else f'clm -I ./ {file_name_without_icl} -o {file_name_without_icl}.out'
                try:
                    log = subprocess.check_output(
                        command, shell=True, stderr=subprocess.STDOUT).decode('utf-8')

                    log = "\n".join(log.split("\n")[:3])
                    # print(log)
                    if log == pass_str:
                        command = f"./{file_name_without_icl}.out"
                        log = subprocess.check_output(
                            command, shell=False, stderr=subprocess.STDOUT).decode('utf-8')

                        test_result = log.split()[::-1][0]
                        # print(f'{function_name} {test}: {test_result}')
                        function_tests[test] = test_result

                    else:
                        print(log)
                        raise subprocess.CalledProcessError(
                            returncode=1, cmd=command)
                except subprocess.CalledProcessError:
                    print(f'ERROR with the test case: {function_name} {test}')

                self.removeLastLineFromFile(file_path)
            file_result[function_name] = function_tests
        print("ENDD")
        return file_result

    def get_student_name_from_path(self, file_path):
        return re.findall(r'(.*/)?(.+)(.icl)', file_path)[0]

    def display_diff(self, teacher_result, students_results):
        for student in students_results:
            print(f'results for student: {student}')
            for function in students_results[student]:
                for test in students_results[student][function]:
                    print(f'  {function} {test}:')
                    print(
                        f'        student result: {students_results[student][function][test]}')
                    print(
                        f'        teacher result: {self.teacher_result[function][test]}')
            print('\n')

    def create_report(self, teacher_result, students_results):
        pass

    def check_for_plagiarism(self):
        pass


def main(args):
    correctTest = CorrectTest(args)


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("-f", "--file", type=str, default="config.yaml",
                    help="config file for the main info")
    ap.add_argument("-tn", "--threads-number", type=int, default=1,
                    help="Number of threads the application allowed to use")

    args = vars(ap.parse_args())
    main(args)
