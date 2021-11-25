import yaml
import re
import os


class CorrectTest:
    def __init__(self, args):
        with open(args["file"], 'r') as config:
            yamlData = yaml.safe_load(config)
            self.teacher_file = yamlData["teacher_file"]
            self.student_files = yamlData["student_files"]
            self.test_questions = yamlData["test_questions"]

    def removeStartFromStudeFile(self):
        fileWithoutStarts = []
        with open(self.student_files[0], 'r+') as read_obj:
            fileContent = read_obj.readlines()
            read_obj.seek(0)
            for line in fileContent:
                if not re.search(r"(//)*( )*Start( )*=( )*", line):
                    read_obj.write(line)
                    fileWithoutStarts.append(line)
            read_obj.truncate()

        return fileWithoutStarts

    def testStudentFile(self):
        fileWithoutStarts = self.removeStartFromStudeFile()
        for question in self.test_questions:
            functionName = self.test_questions[f'{question}']["function_name"]
            for test in self.test_questions[f'{question}']["test_cases"]:
                with open("test.icl", 'a') as write_obj:
                    write_obj.write(f'Start = {functionName} {test}\n')

                command = 'clm test'
                log = os.system(command)
                print(f"LOG: {log}")
                if log == 0:
                    command = "./a.out"
                    log = os.system(command)
                    print(log)
                else:
                    print(
                        f'ERROR with the test case: {functionName} {test}')

    def checkForPlagiarism(self):
        pass
