from CorrectTest import CorrectTest
import argparse
import os


def main(args):
    correctTest = CorrectTest(args)
    print(correctTest.removeStartFromStudeFile())


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("-F", "--file", type=str, default="config.yaml",
                    help="config file for the main info")

    args = vars(ap.parse_args())
    main(args)
