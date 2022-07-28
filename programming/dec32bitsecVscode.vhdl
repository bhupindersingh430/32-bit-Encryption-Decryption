library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dec32Part2 is
port(
    
     permutedData: buffer bit_vector(31 downto 0) := x"0020ABD8";

     firstHalf16Bit: buffer bit_vector(15 downto 0);

     secondHalf16Bit: buffer bit_vector(15 downto 0);

     key1: buffer bit_vector(15 downto 0) := "0000000000000101";

     key3: buffer bit_vector(15 downto 0) := "0000000000001001";

     nBitROR: buffer bit_vector(15 downto 0);

     mBitROR: buffer bit_vector(15 downto 0);

     exor1: buffer bit_vector(15 downto 0);

     exor2: buffer bit_vector(15 downto 0);

     decryptedData: buffer bit_vector(31 downto 0));

   end dec32Part2;

   architecture behavior of dec32Part2 is
   begin


--**divding the encrypted 32-bit data into two 16-bit binary numbers

   --first half 16-bit binary of encrypted data
   process is
    begin
      for i in 0 to 15 loop
        firstHalf16Bit(15 - i) <= permutedData(31 - i);
      end loop;
      wait;
    end process;

  --second half 16-bit binary of encrypted data
  process is
    begin
      for i in 0 to 15 loop
        secondHalf16Bit(i) <= permutedData(i);
      end loop;
      wait;
    end process;



  --**first-half of the decryption algorithm

  --since, key 2(n) was taken 3, so we will do 3-bit right rotations
  nBitROR <= (firstHalf16Bit) ror 3;

  --xor of the first half of 16-bit binary (achieved as output) and key 1
  exor1 <= nBitROR xor key1;



  --**second-half of the decryption algorithm

  --since, key 4(m) was taken 2, so we will do 2-bit right rotations
  mBitROR <= (secondHalf16Bit) ror 2;

  --xor of the second half of 16-bit binary (achieved as output) and key 3
  exor2 <= mBitROR xor key3;



  --**let's append the 16-bit data's we got from both the sides
  decryptedData <= exor1 & exor2;
  --the above 32-bit data is the decrypted data of the the 32-bit password

end behavior;