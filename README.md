# My-Bash-Scripts
A collection of bash scripts that I have wrote

1. [runSuite.sh](https://github.com/MQian21/My-Bash-Scripts/blob/main/runSuite.sh):


    Invoked as follows:
    
        ./runSuite.sh suite-file program
        
        
        The argument 'suite-file' is the name of a file containing a list of filename stems and the argument 'program' is the name 
        of the program to be run.
        
        In summary, the runSuite.sh script runs 'program' on each test in the test suite (as specified by 'suite-file') and reports
        on any tests whose output does not match the expected output. If all tests are passed no output will be produced by the script.
        
    Example of output message if a test fails:
    
    ![image](https://user-images.githubusercontent.com/88065831/170803753-37896118-98f3-4291-89c4-6ea079a3be62.png)




