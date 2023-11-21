LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-------------------------------------------------------------------------------
ENTITY KEYPAD_INTERFACE IS
    PORT (
			CLK		: IN  STD_LOGIC; 						
			RESET     	: IN  STD_LOGIC; 							
			ROWS		: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);	
	COLUMNS: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);		
			KEY_PRESS	: OUT STD_LOGIC;						
			SEG_EN	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);	
SEG_DISP	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 		
    );
END KEYPAD_INTERFACE;
--------------------------------------------------------------------------

ARCHITECTURE KEYPAD_ARCH OF KEYPAD_INTERFACE IS
----------------------------------------------------------------------

SIGNAL SCAN_CLK	: 	STD_LOGIC; 	--SCAN CLOCK

SIGNAL CLK_DIV 		: 	STD_LOGIC_VECTOR(14 DOWNTO 0);      	
SIGNAL COL_SIGNAL   	:  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL KEY_IN  		:  STD_LOGIC;
SIGNAL KEY_CODE_S    :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN


SEG_EN 		<= "0001" ;
KEY_PRESS	<= KEY_IN;
COLUMNS 		<= COL_SIGNAL;

SCAN_CLK  	<= CLK_DIV(14);
-- CLOCK DIVIDER
    PROCESS(CLK,RESET)
    BEGIN
	IF RESET = '1' THEN 
		CLK_DIV	<= (OTHERS=>'0');
	 ELSIF CLK'EVENT AND CLK='1' THEN
	CLK_DIV <= CLK_DIV +1;
        END IF ;
    END PROCESS;


--	SCAN PATTERN GENERATOR
	PROCESS(SCAN_CLK,RESET)
	BEGIN
		IF(RESET = '1')THEN
			COL_SIGNAL <= "1110";
		ELSIF(SCAN_CLK'EVENT AND SCAN_CLK = '0')THEN
		COL_SIGNAL <= COL_SIGNAL(0) & COL_SIGNAL(3 DOWNTO 1);
		END IF;
	END PROCESS;
--------------------------------------------------------------------------        
-- PROCESS FOR KEY PRESS DETECTION
KEY_IN <= '1' WHEN ROWS(0)='0' OR ROWS(1)='0' OR ROWS(2)='0' OR ROWS(3)='0' ELSE
          '0';
-------------------------------------------------------------------------------
--	FOR LATCHING THE VALID KEY PRESSED
	PROCESS(KEY_IN, ROWS, RESET )
	BEGIN
		IF RESET = '1' THEN
			KEY_CODE_S <= (OTHERS=>'0');
		ELSIF( KEY_IN = '1'AND KEY_IN'EVENT )THEN
			KEY_CODE_S <= COL_SIGNAL & ROWS;
        END IF;
	END PROCESS;-- CHANGING THE KEY VALUES IN 7-SEGMENT CODING.

WITH KEY_CODE_S SELECT
                                             --          ABCDEFG
SEG_DISP <=	"00000011" WHEN "11101110",   -- 0
	"10011111" WHEN "11101101",   -- 1    
	"00100101" WHEN "11101011",   -- 2
            "00001101" WHEN "11100111",   -- 3
            "10011001" WHEN "11011110",   -- 4
            "01001001" WHEN "11011101",   -- 5
            "01000001" WHEN "11011011",   -- 6
            "00011111" WHEN "11010111",   -- 7
            "00000001" WHEN "10111110",   -- 8
            "00001001" WHEN "10111101",   -- 9
            "00000101" WHEN "10111011",   -- A
            "11000001" WHEN "10110111",   -- B
            "01100011" WHEN "01111110",   -- C
            "10000101" WHEN "01111101",   -- D
            "01100001" WHEN "01111011",   -- E
            "01110001" WHEN "01110111",   -- F
            "00000000" WHEN OTHERS;


END KEYPAD_ARCH;
