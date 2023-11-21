----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:38:30 11/20/2023 
-- Design Name: 
-- Module Name:    prc1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prc1 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
				B : in  STD_LOGIC_VECTOR (3 downto 0);
           MODE1 : in  STD_LOGIC_VECTOR (2 downto 0);
				RESULT : out  STD_LOGIC_VECTOR (3 downto 0);
				FLAG : out  STD_LOGIC_VECTOR (3 downto 0));
end prc1;

architecture Behavioral of prc1 is

beginPROCESS(A,B,MODE1)VARIABLE TEMP:STD_LOGIC_VECTOR (4 downto 0);BEGIN
FLAG <= "0000";
CASE MODEL IS
WHEN "000" =>
TEMP:= ('0' & A) + B;
		FLAG (3)<= TEMP(3);
		FLAG (1) <= TEMP(4);
		IF (TEMP(3 DOWNTO 0)="0000") THEN
		FLAG (2) <= '1';
		else
		flag (2)<='0';
		END IF;
		RESULT <= TEMP (3 DOWNTO 0);
		
		WHEN "001" =>
TEMP: ('0' & A) - B;
		FLAG (3)<= TEMP(3);
		FLAG (1) <= TEMP(4);
		IF (TEMP (3 DOWNTO 0)="0000") THEN
		FLAG (2) <= '1';
		else
		flag (2) <='0';
		END IF;
		RESULT <= TEMP (3 DOWNTO 0);WHEN "011" =>
TEMP: (3 DOWNTO 0 ):=A NAND B;
		FLAG (3)<= TEMP(3);
		FLAG (1) <= TEMP(4);
		IF (TEMP (3 DOWNTO 0)="0000") THEN
		FLAG (2) <= '1';
		else
		flag (2) <='0';
		END IF;
		RESULT <= TEMP (3 DOWNTO 0);WHEN "100" =>
TEMP: (3 DOWNTO 0 ):=A XOR B;
		FLAG (3)<= TEMP(3);
		FLAG (1) <= TEMP(4);
		IF (TEMP (3 DOWNTO 0)="0000") THEN
		FLAG (2) <= '1';
		else
		flag (2) <='0';
		END IF;
		RESULT <= TEMP (3 DOWNTO 0);WHEN "101" =>
TEMP: (3 DOWNTO 0 ):=A XOR B;
		FLAG (3)<= TEMP(3);
		FLAG (1) <= TEMP(4);
		IF (TEMP (3 DOWNTO 0)="0000") THEN
		FLAG (2) <= '1';
		else
		flag (2) <='0';
		END IF;
		RESULT <= TEMP (3 DOWNTO 0);WHEN "110" =>
TEMP: (3 DOWNTO 0 ):=A OR B;
		FLAG (3)<= TEMP(3);
		FLAG (1) <= TEMP(4);
		IF (TEMP (3 DOWNTO 0)="0000") THEN
		FLAG (2) <= '1';
		else
		flag (2) <='0';
		END IF;
		RESULT <= TEMP (3 DOWNTO 0);WHEN "111"=>
		RESULT <= A;END CASE;


TEMP :="00000";
END CASE;
END PROCESS;
end Behavioral;


