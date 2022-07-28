library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity enc32BitPart1 is
port(input32BitData: buffer bit_vector(31 downto 0) :="00000111010110111100110100010101";

     firstHalf16Bit: buffer bit_vector(15 downto 0);

     secondHalf16Bit: buffer bit_vector(15 downto 0);

     key1: in bit_vector(15 downto 0) := "0000000000000101";

     key3: in bit_vector(15 downto 0) := "0000000000001001";

     exor1: buffer bit_vector(15 downto 0);

     exor2: buffer bit_vector(15 downto 0);

     nBitROL: buffer bit_vector(15 downto 0);

     mBitROL: buffer bit_vector(15 downto 0);

     permutedData: buffer bit_vector(31 downto 0)

);

end enc32BitPart1;


architecture behavior of enc32BitPart1 is
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


end behavior;

