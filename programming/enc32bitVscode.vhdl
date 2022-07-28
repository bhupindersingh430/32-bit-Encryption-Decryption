library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity enc32Bit is
port(input32BitData: buffer bit_vector(31 downto 0) :="00000000000000010010101011111111";

     firstHalf16Bit: buffer bit_vector(15 downto 0);

     secondHalf16Bit: buffer bit_vector(15 downto 0);

     key1: in bit_vector(15 downto 0) := "0000000000000101";

     key3: in bit_vector(15 downto 0) := "0000000000001001";

     exor1: buffer bit_vector(15 downto 0);

     exor2: buffer bit_vector(15 downto 0);

     nBitROL: buffer bit_vector(15 downto 0);

     mBitROL: buffer bit_vector(15 downto 0);

     permutedData: buffer bit_vector(31 downto 0);

     permutedDataPOne: buffer bit_vector(31 downto 0);

     permutedDataPTwo: buffer bit_vector(31 downto 0);

     permutedDataPThree: buffer bit_vector(31 downto 0);

     permutedDataPFour: buffer bit_vector(31 downto 0);

     key5: buffer bit_vector(31 downto 0) := "00000000000000000000000001111011";

     firstHalf16BitKey5: buffer bit_vector(15 downto 0);

     secondHalf16BitKey5: buffer bit_vector(15 downto 0);

     firstHalf16BitKey5POne: buffer bit_vector(15 downto 0) :=(others => '0');

     secondHalf16BitKey5POne: buffer bit_vector(15 downto 0) :=(others => '0');

     firstHalf16BitKey5PTwo: buffer bit_vector(15 downto 0) :=(others => '0');

     secondHalf16BitKey5PTwo: buffer bit_vector(15 downto 0) :=(others => '0');

     firstHalf16BitKey5PThree: buffer bit_vector(15 downto 0) :=(others => '0');

     secondHalf16BitKey5PThree: buffer bit_vector(15 downto 0) :=(others => '0');
     
     firstHalf16BitKey5PFour: buffer bit_vector(15 downto 0) :=(others => '0');

     secondHalf16BitKey5PFour: buffer bit_vector(15 downto 0) :=(others => '0');

     helperData: buffer bit_vector(31 downto 0) :=(others => '0')
);

end enc32Bit;


architecture behavior of enc32Bit is
begin

  --**divding the 32-bit data into two 16-bit binary numbers

  --first half 16-bit binary of input data
  process is
    begin
      for i in 0 to 15 loop
        firstHalf16Bit(15 - i) <= input32BitData(31 - i);
      end loop;
      wait;
    end process;

  --second half 16-bit binary of input data
  process is
    begin
      for i in 0 to 15 loop
        secondHalf16Bit(i) <= input32BitData(i);
      end loop;
      wait;
    end process;



  --**first-half of the encryption algorithm

  --xor of the first half of 16-bit binary and key 1
  exor1 <= firstHalf16Bit xor key1;

  --let's take key 2(n) as 3, therefore we will do 3-bit left rotations
  nBitROL <= (exor1) rol 3;




  --**second-half of the encryption algorithm

  --xor of the second-half of 16-bit binary and key 3
  exor2 <= secondHalf16Bit xor key3;

  --let's take key 3(m) as 2, therefore we will do 2-bit left rotations
  mBitROL <= (exor2) rol 2;



  --**let's append the 16-bit data's we got from both the sides
  permutedData <= nBitROL & mBitROL;
  --the above 32-bit data is the cypher data of the the 32-bit password



  --**dividing intial key(key5) into equal 16 bit halves

  --first half 16-bit binary of input data
  process is
    begin
      for i in 0 to 15 loop
        firstHalf16BitKey5(15 - i) <= key5(31 - i);
      end loop;
      wait;
    end process;

  --second half 16-bit binary of input data
  process is
    begin
      for i in 0 to 15 loop
        secondHalf16BitKey5(i) <= key5(i);
      end loop;
      wait;
    end process;

  --**loop 4 times
  --1st loop
  firstHalf16BitKey5POne <= (firstHalf16BitKey5) rol 1;
  --firstHalf16BitKey5P1
  secondHalf16BitKey5POne <= (secondHalf16BitKey5) ror 1;
  permutedDataPOne <= permutedData xor (firstHalf16BitKey5POne & secondHalf16BitKey5POne);

  --2nd loop
  firstHalf16BitKey5PTwo <= firstHalf16BitKey5POne rol 2;
  secondHalf16BitKey5PTwo <= secondHalf16BitKey5POne ror 2;
  permutedDataPTwo <= permutedDataPOne xor (firstHalf16BitKey5PTwo & secondHalf16BitKey5PTwo);

  --3rd loop
  firstHalf16BitKey5PThree <= firstHalf16BitKey5PTwo rol 3;
  secondHalf16BitKey5PThree <= secondHalf16BitKey5PTwo ror 3;
  permutedDataPThree <= permutedDataPTwo xor (firstHalf16BitKey5PThree & secondHalf16BitKey5PThree);

  --4th loop
  firstHalf16BitKey5PFour <= firstHalf16BitKey5PThree rol 4;
  secondHalf16BitKey5PFour <= secondHalf16BitKey5PThree ror 4;
  helperData <= (firstHalf16BitKey5PFour & secondHalf16BitKey5PFour);
  permutedDataPFour <= permutedDataPThree xor (firstHalf16BitKey5PFour & secondHalf16BitKey5PFour);


    --**cypher text 32 bit = permutedDataP4;

end behavior;
