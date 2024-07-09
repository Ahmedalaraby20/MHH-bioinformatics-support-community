# To access the HPC from a Windows machine you can

## a) Use a program like WinSCP (free)

Install the following (Call 7777 if you need help):
- [WinSCP](https://winscp.net/eng/download.php)
- [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

### Using WinSCP:

1. Start WinSCP. You will be greeted with the login window:
![winscp 1](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/raw/main/assets/winscp1.JPG)
   
2. Fill in the fields as follows:
   - Host name: `login.cluster.mh-hannover.local`
   - Username and password: Use the credentials you use to login to your computer/webmail.
   
3. Once logged in, you will land in your home directory:
   ![Home Directory](images/home_directory.png)
   
4. Navigate to your project group directory by clicking on the "Open Directory" button:
   ![Open Directory](images/open_directory.png)
   
5. Write down the project directory, e.g., `/project/ag-singlecellsummer2024/`:
   ![Project Directory](images/project_directory.png)
   
6. Once in the project directory, you can copy files to and from the directory by dragging and dropping.

7. To access the terminal, click on the PuTTY button:
   ![PuTTY](images/putty_button.png)

## b) Use Windows Terminal SSH

Open terminal in Windows and run the following command, then enter your password:
```bash
ssh username@login.cluster.mh-hannover.local
```
![Terminal 1](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/raw/main/assets/terminal1.JPG)

