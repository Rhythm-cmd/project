library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU4BIT is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
B : in  STD_LOGIC_VECTOR (3 downto 0);
           MODE1 : in  STD_LOGIC_VECTOR (2 downto 0);
CIN : in  STD_LOGIC;
RESULT : out  STD_LOGIC_VECTOR (3 downto 0);
COUT : out  STD_LOGIC;
FLAG : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU4BIT;

architecture Behavioral of ALU4BIT is
begin
PROCESS(A,B,CIN,MODE1)
VARIABLE TEMP:STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
CASE MODE1 IS
WHEN "000" =>                                                                                                        --ADDITION
TEMP := ('0' & A ) + B + CIN;
				COUT <=TEMP(4);
				FLAG(3)<= TEMP(3);
				FLAG(1) <= TEMP(4);
				IF (TEMP(3 DOWNTO 0)="0000")THEN
				FLAG(2) <= '1';
				else	
				flag(2)<='0';
				END IF;
				RESULT <= TEMP(3 DOWNTO 0);
				
WHEN "001" => --SUBTRACTION 
TEMP := ('0' & A ) - B - CIN;
				COUT <=TEMP(4);
				FLAG(3)<= TEMP(3);
				FLAG(1) <= TEMP(4);
				IF (TEMP(3 DOWNTO 0)="0000")THEN
				FLAG(2) <= '1';

else	
				flag(2)<='0';
				END IF;
				RESULT <= TEMP(3 DOWNTO 0);

WHEN "010" =>                                                                                                                   --AND 
TEMP(3 DOWNTO 0) := A AND B;
				FLAG(3)<= TEMP(3);
				IF (TEMP(3 DOWNTO 0)="0000")THEN
				FLAG(2) <= '1';
else	
				flag(2)<='0';
				END IF;
				RESULT <= TEMP(3 DOWNTO 0);
				
WHEN "011" =>                                                                                        --NAND 
TEMP(3 DOWNTO 0) := A NAND B;
				FLAG(3)<= TEMP(3);
				IF (TEMP(3 DOWNTO 0)="0000")THEN
				FLAG(2) <= '1';
else	
				flag(2)<='0';
				END IF;
				RESULT <= TEMP(3 DOWNTO 0);
WHEN "100" =>                                                                                                       --XOR 
TEMP(3 DOWNTO 0) := A XOR B;
				FLAG(3)<= TEMP(3);
				IF (TEMP(3 DOWNTO 0)="0000")THEN
				FLAG(2) <= '1';
else	
				flag(2)<='0';
				END IF;
				RESULT <= TEMP(3 DOWNTO 0);
				
WHEN "101" =>   --XNOR 
TEMP(3 DOWNTO 0) := A XNOR B;
				FLAG(3)<= TEMP(3);
				IF (TEMP(3 DOWNTO 0)="0000")THEN
				FLAG(2) <= '1';
else	
				flag(2)<='0';
				END IF;
				RESULT <= TEMP(3 DOWNTO 0);
					
WHEN "110" =>                                                                                                                   --OR 
TEMP(3 DOWNTO 0) := A OR B;
				FLAG(3)<= TEMP(3);
				IF (TEMP(3 DOWNTO 0)="0000")THEN                         
				FLAG(2) <= '1';
else	
				flag(2)<='0';
				END IF;
				RESULT <= TEMP(3 DOWNTO 0);

WHEN "111" =>                                                                                    --ALU PASS FOR A
				RESULT <= A;				
				
WHEN OTHERS =>		NULL	;	

END CASE;
END PROCESS;				
END BEHAVIORAL;
