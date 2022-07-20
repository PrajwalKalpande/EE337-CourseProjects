#include <at89c5131.h>
#include "endsem.h"

char S_str[6] = {0, 0, 0, 0, 0, 0}; // String for Balance Sita
char G_str[6] = {0, 0, 0, 0, 0, 0}; // String for Balance Gita
char n500_s[3] = {0, 0, 0};         // STRING FOR 500RS NOTE
char n100_s[3] = {0, 0, 0};         // STRING FOR 100RS NOTE
unsigned int balance1;
unsigned int balance2;
unsigned int withdrawh1;
unsigned int withdrawh2;
unsigned int temp1, temp2;
unsigned int quit = 0;
unsigned int i;
unsigned char ch, ch_acc, ch_with;
char password[5] = {0, 0, 0, 0, 0}; // PASSWORD ARRAY
// Main function

//-------------------------------------------------
void main(void)
{
    uart_init(); // Please finish this function in endsem.h
    balance1 = 10000;
    balance2 = 10000;

    while (1)
    {
        transmit_string("Press A for Account display and W for withdrawing cash\r\n");

        /* code */
        ch = receive_char();
        if (ch == 'a' | ch == 'A')
        {
            transmit_string("Hello, Please enter Account Number\r\n");
            ch_acc = receive_char();
            switch (ch_acc)
            {
            case '1':
                // quit = 0;
                // transmit_string("Please enter password\r\n");
                // password[0] = 'E';
                // password[1] = 'E';
                // password[2] = '3';
                // password[3] = '3';
                // password[4] = '7';
                // for (i = 0; i < 5; i++)
                // {
                //     ch = receive_char();
                //     if (ch != password[i])
                //     {
                //         quit = 1;
                //         break;
                //     }
                // }
                // if (quit)
                // {
                //     break;
                // }
                int_to_string(balance1, S_str);
                transmit_string("Account Holder: Sita\r\n");
                transmit_string("Account Balance: ");
                transmit_string(S_str);
                transmit_string("\r\n");

                break;

            case '2':
                // transmit_string("Please enter password\r\n");
                // quit = 0;

                // password[0] = 'U';
                // password[1] = 'P';
                // password[2] = 'L';
                // password[3] = 'A';
                // password[4] = 'B';
                // for (i = 0; i < 5; i++)
                // {
                //     ch = receive_char();
                //     if (ch != password[i])
                //     {
                //         quit = 1;
                //         break;
                //     }
                // }
                // if (quit)
                // {
                //     break;
                // }
                int_to_string(balance2, G_str);
                transmit_string("Account Holder: Gita\r\n");

                transmit_string("Account Balance: ");
                transmit_string(G_str);
                transmit_string("\r\n");

                break;

            default:
                transmit_string("No such account, please enter valid details\r\n");
                break;
            }

            continue;
        }

        else if (ch == 'w' | ch == 'W')
        {
            transmit_string("Withdraw state, enter account number\r\n");
            ch_with = receive_char();
            switch (ch_with)
            {
            case '1':
                quit = 0;
                transmit_string("Please enter password\r\n");
                password[0] = 'E';
                password[1] = 'E';
                password[2] = '3';
                password[3] = '3';
                password[4] = '7';
                for (i = 0; i < 5; i++)
                {
                    ch = receive_char();
                    if (ch != password[i])
                    {
                        quit = 1;
                        break;
                    }
                }
                if (quit)
                {
                    break;
                }

                withdrawh1 = 0; // not needed
                int_to_string(balance1, S_str);
                transmit_string("Account Holder: Sita\r\n");
                transmit_string("Account Balance: ");
                transmit_string(S_str);
                transmit_string("\r\n");
                transmit_string("Enter Amount, in hundreds\r\n");
                ch = receive_char();

                withdrawh1 = (ch - 48);
                if (withdrawh1<0 | withdrawh1> 9)
                {
                    transmit_string("Invalid Amount\r\n");
                    break;
                }
                withdrawh1 *= 10;
                ch = receive_char();
                if (ch - 48 < 0 | ch - 48 > 9)
                {
                    transmit_string("Invalid Amount\r\n");
                    break;
                }
                withdrawh1 += (ch - 48);
                temp1 = balance1 / 100;
                if (withdrawh1 > temp1)
                {
                    transmit_string("Insufficient Funds\r\n");
                    break;
                }
                balance1 -= withdrawh1 * 100;
                int_to_string(balance1, S_str);
                transmit_string("Remaining Balance: ");
                transmit_string(S_str);
                transmit_string("\r\n");
                temp1 = (withdrawh1) / 5;
                temp2 = withdrawh1 % 5;

                transmit_string("500 Notes: ");
                int_to_string_2(temp1, n500_s);
                int_to_string_2(temp2, n100_s);
                transmit_string(n500_s);
                transmit_string(", 100 Notes: ");
                transmit_string(n100_s);
                transmit_string("\r\n");
                break;

            case '2':

                quit = 0;
                transmit_string("Please enter password\r\n");
                password[0] = 'U';
                password[1] = 'P';
                password[2] = 'L';
                password[3] = 'A';
                password[4] = 'B';
                for (i = 0; i < 5; i++)
                {
                    ch = receive_char();
                    if (ch != password[i])
                    {
                        quit = 1;
                        break;
                    }
                }
                if (quit)
                {
                    break;
                }
                withdrawh2 = 0; // not needed
                int_to_string(balance2, G_str);
                transmit_string("Account Holder: Gita\r\n");
                transmit_string("Account Balance: ");
                transmit_string(G_str);
                transmit_string("\r\n");
                transmit_string("Enter Amount, in hundreds\r\n");
                ch = receive_char();

                withdrawh2 = (ch - 48);
                if (withdrawh2<0 | withdrawh2> 9)
                {
                    transmit_string("Invalid Amount\r\n");
                    break;
                }
                withdrawh2 *= 10;
                ch = receive_char();
                if (ch - 48 < 0 | ch - 48 > 9)
                {
                    transmit_string("Invalid Amount\r\n");
                    break;
                }
                withdrawh2 += (ch - 48);
                temp2 = balance2 / 100;
                if (withdrawh2 > temp2)
                {
                    transmit_string("Insufficient Funds\r\n");
                    break;
                }
                balance2 -= withdrawh2 * 100;
                int_to_string(balance2, G_str);
                transmit_string("Remaining Balance: ");
                transmit_string(G_str);
                transmit_string("\r\n");
                temp1 = withdrawh2 / 5;
                temp2 = withdrawh2 % 5;

                transmit_string("500 Notes: ");
                int_to_string_2(temp1, n500_s);
                int_to_string_2(temp2, n100_s);
                transmit_string(n500_s);
                transmit_string(", 100 Notes: ");
                transmit_string(n100_s);
                transmit_string("\r\n");
                break;

            default:
                transmit_string("No such account, please enter valid details\r\n");
                break;
            }

            continue;
        }

        // YOUR CODE GOES HERE
    }
}
