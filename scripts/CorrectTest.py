import subprocess
import yaml
import re


class CorrectTest:
    def __init__(self, args):
        with open(args["file"], 'r') as config:
            yamlData = yaml.safe_load(config)
            self.teacher_file = yamlData["teacher_file"]
            self.student_files = yamlData["student_files"]
            self.test_questions = yamlData["test_questions"]

    def removeLastLineFromFile(self):
        with open(self.student_files[0], 'r+') as read_obj:
            fileContent = read_obj.readlines()
            fileContent = fileContent[:len(fileContent) - 1]
            read_obj.seek(0)
            for line in fileContent:
                read_obj.write(line)
            read_obj.truncate()

    def removeStartFromStudeFile(self):
        with open(self.student_files[0], 'r+') as read_obj:
            fileContent = read_obj.readlines()
            read_obj.seek(0)
            for line in fileContent:
                if not re.search(r"(//)*( )*Start( )*=( )*", line):
                    read_obj.write(line)
            read_obj.truncate()

    def testStudentFile(self, studentFile):
        self.removeStartFromStudeFile()
        pass_str = "Compiling test\nGenerating code for test\nLinking test"
        for index, question in enumerate(self.test_questions):
            functionName = question[f'q{index + 1}']["function_name"]
            for test in question[f'q{index + 1}']["test_cases"]:
                with open(studentFile, 'a') as write_obj:
                    write_obj.write(f'Start = {functionName} {test}\n')

                command = f'clm {studentFile.split(".")[0]}'
                try:
                    log = subprocess.check_output(
                        command, shell=True, stderr=subprocess.STDOUT).decode('utf-8')
                    log = "\n".join(log.split("\n")[:3])
                    if log == pass_str:
                        command = "./a.out"
                        log = subprocess.check_output(
                            command, shell=False, stderr=subprocess.STDOUT).decode('utf-8')
                        print(log)
                    else:
                        raise subprocess.CalledProcessError(
                            returncode=1, cmd=command)
                except subprocess.CalledProcessError:
                    print(f'ERROR with the test case: {functionName} {test}')

                self.removeLastLineFromFile()

    def putResultsIntoSpreadsheet(self, teacherResults, studentsResults):
        pass

    def checkForPlagiarism(self):
        pass


"""
fst correct teacher file then store in a global dict
then loop over students files and then correct them one by one and store the results in a global dict as well.

"""
