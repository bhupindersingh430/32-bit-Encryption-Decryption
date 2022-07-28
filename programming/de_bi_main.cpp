#include <iostream>

int *decimalToBinary(int decimal, int bit_size)
{

    //dynamic array to store binary number
    int *binaryNum = new int[bit_size]();

    //dynamic array to store the binary number in reverse to binaryNum array
    int *binary = new int[bit_size + 1];
    for (int i = 0; i < bit_size + 1; i++)
        binary[i] = -1;

    //counter for binary array
    int i = 0;
    while (decimal > 0)
    {
        //storing remainder in binary array
        binaryNum[i] = decimal % 2;
        decimal = decimal / 2;
        i++;
    }
    i--;

    //copying data members of binaryNum to binary in reversed form wrt binaryNum
    for (int j = 0; i >= 0; j++)
        binary[j] = binaryNum[i--];
    i++;

    delete[] binaryNum;
    return binary;
}

int main()
{
    int decimal, bit_size;

    std::cout << std::endl;
    std::cout << "Enter the bit-size required as per the password to be entered: ";
    std::cin >> bit_size;

    std::cout << "Enter the password to be encrypted: ";
    std::cin >> decimal;

    //final_binary is a dynamic array with all elements initialized to 0
    int *final_binary = new int[bit_size]();

    //the pointer binary point towards the binary array of decimaoToBinary function
    int *binary = decimalToBinary(decimal, bit_size);

    //loop for finding out the size of the binary number
    int size = 0, i = 0;
    while (binary[i] != -1)
    {
        size++;
        i++;
    }

    //copying the data members of binary array as trailing members of final_binary
    int k = 0;
    for (int j = bit_size - size; j < bit_size; j++)
        final_binary[j] = binary[k++];

    //printing out the binary conversion of decimal in total bit size provided initially
    std::cout << std::endl;
    std::cout << "-> The " << bit_size << "-bit binary number of the entered decimal " << decimal << " is: ";
    for (int j = 0; j < bit_size; j++)
        std::cout << final_binary[j];
        
    std::cout << std::endl;
    std::cout << std::endl;

    // //dividing the final_binary directly by 2 for getting the bit seperation
    // std::cout << "-> First " << bit_size / 2 << "-bit binary number is: ";
    // for (int j = 0; j < bit_size / 2; j++)
    //     std::cout << final_binary[j];

    // std::cout << std::endl;

    // std::cout << "-> Remaining " << bit_size / 2 << "-bit binary number is: ";
    // for (int j = bit_size / 2; j < bit_size; j++)
    //     std::cout << final_binary[j];

    // std::cout << std::endl;

    delete[] binary;
    delete[] final_binary;
}