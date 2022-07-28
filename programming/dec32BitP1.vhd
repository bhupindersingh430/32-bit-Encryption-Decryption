library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dec32Part1 is
port(
     cypherData: buffer bit_vector(31 downto 0) := x"3AF02680";
     
     helperData: buffer bit_vector(31 downto 0) := x"00001EC0";

     permutedDataPThree: buffer bit_vector(31 downto 0);

     permutedDataPTwo: buffer bit_vector(31 downto 0);

     permutedDataPOne: buffer bit_vector(31 downto 0);

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

     permutedData: buffer bit_vector(31 downto 0)
);

   end dec32Part1;

   architecture behavior of dec32Part1 is
   begin


-- ***with the help of xoring of cypherData and helperData we 
-- will retrieve back permutedDataPThree

-- 1st step
permutedDataPThree <= cypherData xor helperData;

--first half 16-bit binary of helper data
process is
  begin
    for i in 0 to 15 loop
      firstHalf16BitKey5PFour(15 - i) <= helperData(31 - i);
    end loop;
    wait;
  end process;

--second half 16-bit binary of input data
process is
  begin
    for i in 0 to 15 loop
      secondHalf16BitKey5PFour(i) <= helperData(i);
    end loop;
    wait;
  end process;

--ROR by 4 the firstHalf16BitKey5PFour and ROL by 4 the secondHalf16BitKey5PFour
firstHalf16BitKey5PThree <= firstHalf16BitKey5PFour ror 4;
secondHalf16BitKey5PThree <= secondHalf16BitKey5PFour rol 4;


-- 2nd step
permutedDataPTwo <= permutedDataPThree xor (firstHalf16BitKey5PThree & secondHalf16BitKey5PThree);


--ROR by 3 the firstHalf16BitKey5PThree and ROL by 3 the secondHalf16BitKey5PThree
firstHalf16BitKey5PTwo <= firstHalf16BitKey5PThree ror 3;
secondHalf16BitKey5PTwo <= secondHalf16BitKey5PThree rol 3;


-- 3rd step
permutedDataPOne <= permutedDataPTwo xor (firstHalf16BitKey5PTwo & secondHalf16BitKey5PTwo);


--ROR by 2 the firstHalf16BitKey5PTwo and ROL by 2 the secondHalf16BitKey5PTwo
firstHalf16BitKey5POne <= firstHalf16BitKey5PTwo ror 2;
secondHalf16BitKey5POne <= secondHalf16BitKey5PTwo rol 2;


-- 4th step
permutedData <= permutedDataPOne xor (firstHalf16BitKey5POne & secondHalf16BitKey5POne);


--ROR by 1 the firstHalf16BitKey5PThree and ROL by 1 the secondHalf16BitKey5PThree
firstHalf16BitKey5 <= firstHalf16BitKey5POne ror 1;
secondHalf16BitKey5 <= secondHalf16BitKey5POne rol 1;



end behavior;
