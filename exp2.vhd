library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.All;


entity reg is
    Port ( din : in  STD_LOGIC_VECTOR (03 downto 0);
dout :inout  STD_LOGIC_VECTOR (3 downto 0);
           mode1 : in  STD_LOGIC_VECTOR (1 downto 0);
clk : in  STD_LOGIC;
rst : in  STD_LOGIC);
end reg;

architecture Behavioral of reg is

signal MSBIN,LSBIN :STD_LOGIC;
signal TEMP: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL CLK_DIV : STD_LOGIC_VECTOR(21 DOWNTO 0);

begin

MSBIN <= DIN(3);
LSBIN <= DIN(0);

PROCESS(CLK,RST)
BEGIN

IF (RST= '1')THEN
CLK_DIV <= (OTHERS => '0');
ELSIF(CLK'EVENT AND CLK ='1')THEN
CLK_DIV <= CLK_DIV + '1';
END IF;
END PROCESS;

PROCESS(CLK_DIV(21),RST)
BEGIN
IF(RST ='1')THEN
DOUT <= "0000";
temp <= "0000";
ELSIF(CLK_DIV(21)'EVENT AND CLK_DIV(21) ='1')THEN
CASE MODE1 IS
WHEN "00" =>
				DOUT <= MSBIN &DOUT(3 DOWNTO 1); --SISO(rt shift)
WHEN "01" =>
				DOUT <= DIN;                      --PIPO  
WHEN "10" =>
				temp <= MSBIN &temp(3 DOWNTO 1);         --SIPO
				dout<=temp;
WHEN "11" =>
				DOUT <= DOUT(2 DOWNTO 0) & LSBIN; --SISO(left shift) 

WHEN OTHERS =>
				DOUT <= "0000";				

END CASE;
END IF;
END PROCESS;				
END BEHAVIORAL;
