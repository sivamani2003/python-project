import pickle
import os
import pathlib
import random

def Pin_check(pin1):
        for i in range(3):
            Pin = int(input("\tEnter your pin\t\t\t: "))
            if pin1 == Pin:
                return True
            else:
                print("\n\tInvalid pin, please try again.")
        
        print("\n\tYou have entered your pin wrong for more than 3 times, you cannot continue")
        return False

class Account:
    accNo=0
    def Show_Account(self):
        os.system("clear")
        print("\n\tAccount Details : \n")
        print("\tAccount Number \t\t:\t ", self.accNo)
        print("\tAccount Pin \t\t:\t ", self.pin)
        print("\tAccount Holder Name \t:\t ", self.name)
        print("\tType of Account  \t:\t ", self.type)
        print("\tBalance \t\t:\t ", self.balance)
        self.str = input("\n\tPress enter to return back to MainMenu : ")
        os.system("clear")

    def Create_Account(self):
        self.chance = 3
        self.name = input("\tEnter the account holder name\t  :   ")
        for i in self.name:
            if i in '0123456789!@#$%^&*()':
                print("Invalid input")
        self.o = int(input("\n\t1.Current \n\t2.Savings \n\tEnter the type of account\t  :   "))
        if self.o==1:
            self.type='Current'
        else:
            self.type='Savings'
        self.balance = int(input("\n\tEnter the initial deposit amount  :   "))
        self.accNo = '41112'
        for i in range(5):
            self.accNo+=str(random.randint(0,9))
        self.pin = int(input("\n\tSet a 4 digit pin\t\t  :   "))
        print("\n\tYour Account has been created")
        self.str = input()
        
def Upload_Account_File(account) : 
    file = pathlib.Path("accounts.data")
    if file.exists():
        infile = open('accounts.data','rb')
        oldlist = pickle.load(infile)
        oldlist.append(account)
        infile.close()
        os.remove('accounts.data')
    else :
        oldlist = [account]
    outfile = open('newaccounts.data','wb')
    pickle.dump(oldlist, outfile)
    outfile.close()
    os.rename('newaccounts.data', 'accounts.data')
    
def New_Account():
    account = Account()
    account.Create_Account()
    account.Show_Account()
    Upload_Account_File(account)
    

def Account_list():
    file = pathlib.Path("accounts.data")
    if file.exists ():
        infile = open('accounts.data','rb')
        mylist = pickle.load(infile)
        i = 1
        for item in mylist :
            print("\t", i,". Account No : ", item.accNo)
            print("\t\tName\t: ", item.name)
            print("\t\tType\t: ",item.type)
            print("\t\tBalance : ", item.balance,"\n\n")            
            i+=1
        infile.close()
        str = input("\n\tPress enter to return back to MainMenu : ")
        os.system("clear")
    else :
        print("\tNo records to display")
        str = input("\n\tPress enter to return back to MainMenu : ")
        os.system("clear")

def Balance_Enquriy(num): 
    file = pathlib.Path("accounts.data")
    if file.exists ():
        infile = open('accounts.data','rb+')
        mylist = pickle.load(infile)
        found = False
        infile.close()
        for item in mylist:
            if item.accNo == num:
                if item.chance > 0:
                    if Pin_check(item.pin):
                        print("\tAvailable Balance\t\t: ",item.balance)
                        str = input("\n\tPress enter to return back to MainMenu : ")
                        os.system("clear")
                        found = True
                    else:
                        item.chance = 0
                        outfile = open('newaccounts.data','wb')
                        pickle.dump(mylist, outfile)
                        outfile.close()
                        os.rename('newaccounts.data', 'accounts.data')
                else:
                    print("\tIt seems your account has been banned, please contact the manager")
    else:
        print("\tNo records to Search")
    if not found :
        print("\tNo existing record with this number")
        str = input("\n\tPress enter to return back to MainMenu : ")
        os.system("clear")

def Deposit_and_Withdraw(num1,num2): 
    flag=1
    file = pathlib.Path("accounts.data")
    if file.exists ():
        infile = open('accounts.data','rb')
        mylist = pickle.load(infile)
        infile.close()
        os.remove('accounts.data')
        for item in mylist :
            if item.accNo == num1 :
                flag=0
                if item.chance > 0:
                    if Pin_check(item.pin):
                        if num2 == 1 :
                            amount = int(input("\tEnter the amount to deposit \t: "))
                            item.balance += amount
                            print("\n\tYour account balance has been updated")
                            print("\tUpdated Balance \t\t: ", item.balance)
                            str = input("\n\tPress enter to return back to MainMenu : ")
                            os.system("clear")
                        elif num2 == 2 :
                            amount = int(input("\tEnter the amount to withdraw\t: "))
                            if amount <= item.balance:
                                item.balance -= amount
                                print("\n\tUpdated Balance \t\t: ", item.balance)
                                str = input("\n\tPress enter to return back to MainMenu : ")
                                os.system("clear")
                            else :
                                print("\n\tInsufficient balance to withdraw")
                                str = input("\n\tPress enter to return back to MainMenu : ")
                                os.system("clear")
                    else:
                        item.chance = 0
        if flag:
            print("\n\tInvalid Account Number.")
            str = input("\n\tPress enter to return back to MainMenu : ")
            os.system("clear")
    else :
        print("No records to Search")
    outfile = open('newaccounts.data','wb')
    pickle.dump(mylist, outfile)
    outfile.close()
    os.rename('newaccounts.data', 'accounts.data')
    
def Close_Account(num):
    flag = 1
    file = pathlib.Path("accounts.data")
    if file.exists():
        infile = open('accounts.data','rb')
        oldlist = pickle.load(infile)
        infile.close()
        newlist = []
        for item in oldlist :
            if item.accNo == num:
                flag = 0
                if Pin_check(item.pin):
                    while(1):
                        L = input("\tDo you want to close your account [ Yes / No ] : ")
                        if L == 'Yes' or L == 'y' or L == 'Y':
                            for item in oldlist :
                                if item.accNo != num:
                                    newlist.append(item)
                            os.remove('accounts.data')
                            print("\n\tAccount No. : ", num)
                            print("\n\tHas been closed")
                            flag = 2
                            break
                        elif L == 'No' or L == 'N' or L == 'n':
                            print("\n\tAccount Closing Cancelled.")
                            break
                        else:
                            str = input("\n\tPlease enter an valid input : ")
                    str = input("\n\tPress enter to return back to MainMenu : ")
                    os.system("clear")
                break
        if flag == 1:
            print("\n\tInvalid Account Number.")
            str = input("\n\tPress enter to return back to MainMenu : ")
            os.system("clear")
    else:
        print("No records to Search")
    if flag  == 2:
        outfile = open('newaccounts.data','wb')
        pickle.dump(newlist, outfile)
        outfile.close()
        os.rename('newaccounts.data', 'accounts.data')
     
def Modify_Account(num):
    flag = 1
    file = pathlib.Path("accounts.data")
    if file.exists ():
        infile = open('accounts.data','rb')
        oldlist = pickle.load(infile)
        infile.close()
        os.remove('accounts.data')
        for item in oldlist :
            if item.accNo == num :
                flag = 0
                if item.chance > 0:
                    if Pin_check(item.pin):
                        while(1):
                            change = int(input("\n\t1.Name \n\t2.Type \n\t3.Pin \n\tSelect from the above options to change : "))
                            if change == 1:
                                item.name = input("\n\tEnter the account holder name\t: ")
                                print("\n\tAccount Name Updated : ", item.name)
                                break
                            elif change == 2:
                                item.type = input("\n\tEnter the account Type\t\t: ")
                                print("\n\tAccount type Updated : ", item.type)
                                break
                            elif change == 3:
                                item.pin = int(input("\n\tEnter the Pin\t\t\t: "))
                                print("\n\tAccount Pin Updated : ", item.pin)
                                break
                            else:
                                print("\n\tPlease enter an valid option from the following : ")
                    else:
                        item.change = 0
        if flag:
            print("\tInvalid or Incorrect Account Number.")
        outfile = open('newaccounts.data','wb')
        pickle.dump(oldlist, outfile)
        outfile.close()
        os.rename('newaccounts.data', 'accounts.data')
        str = input("\n\tPress enter to return back to MainMenu : ")
        os.system("clear")
  
def intro():
    #os.system("clear")
    print("\t\t\t\t**********")
    print("\t\t\t\t BANK MANAGEMENT SYSTEM")
    print("\t\t\t\t**********\n")
        
################# start of the program ######################
ch = 0
num=0
while ch != 8:
    intro()
    print("\t  MAIN MENU : ")
    print("\t\t1.NEW ACCOUNT")
    print("\t\t2.DEPOSIT AMOUNT")
    print("\t\t3.WITHDRAW AMOUNT")
    print("\t\t4.BALANCE ENQUIRY")
    print("\t\t5.ACCOUNT HOLDERS LIST")
    print("\t\t6.CLOSE AN ACCOUNT")
    print("\t\t7.MODIFY AN ACCOUNT")
    print("\t\t8.EXIT")
    ch = input("\t\tSelect from the above options : ")
    os.system("clear")
    if ch == '1':
        intro()
        print("\tOPEN NEW ACCOUNT : \n")
        New_Account()
    elif ch =='2':
        intro()
        print("\tDEPOSIT AMOUNT : \n")
        num = (input("\tEnter the Account No. \t\t: "))
        Deposit_and_Withdraw(num, 1)
    elif ch == '3':
        intro()
        print("\tWITHDRAW AMOUNT : \n")
        num = (input("\tEnter the Account No. \t\t: "))
        Deposit_and_Withdraw(num, 2)
    elif ch == '4':
        intro()
        print("\tBALANCE ENQUIRY : \n")
        num = (input("\tEnter your Account No. \t\t: "))
        Balance_Enquriy(num)
    elif ch == '5':
        intro()
        print("\tACCOUNT HOLDERS LIST : \n")
        Account_list();
    elif ch == '6':
        intro()
        print("\tCLOSE AN ACCOUNT : \n")
        num = (input("\tEnter your Account No. \t\t: "))
        Close_Account(num)
    elif ch == '7':
        intro()
        num = (input("\tEnter your Account No. \t\t: "))
        Modify_Account(num)
    elif ch == '8':
        print("\tThanks for using bank managemnt system")
        str = input()
        break
    else :
        print("\n\tInvalid choice, please enter from the following options : \n\t")
