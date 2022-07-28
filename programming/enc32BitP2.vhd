library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity enc32BitPart2 is
port(
     permutedData: buffer bit_vector(31 downto 0) := x"3AF03473";

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

end enc32BitPart2;


architecture behavior of enc32BitPart2 is
begin


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

