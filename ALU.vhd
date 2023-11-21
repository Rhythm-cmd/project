library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity myfifo_1 is
    Port ( datain : in  STD_LOGIC_VECTOR (7 downto 0);
en,clk,rst : in  STD_LOGIC;
W : in  STD_LOGIC;
DATAOUT : OUT  STD_LOGIC_VECTOR (7 downto 0);
RED : OUT  STD_LOGIC);
end myfifo_1;

architecture Behavioral of myfifo_1 is
SIGNAL WPTR, RPTR :STD_LOGIC_VECTOR(3 DOWNTO 0);
Type fifo is array(15 downto 00) of STD_LOGIC_VECTOR(07 downto 00);
signal mem:fifo;
signal clk_div: std_logic_vector(21 downto 0);
begin
process(clk,rst)  
begin
if rst ='1' then
clk_div<=(others=>'0');
elsif (clk'event and clk='1') then
clk_div<=clk_div+1;
end if;
end process;
Process(clk_DIV(21),rst)                                  ----0 for simulation 21 for implementation
begin
if rst ='1' then
wptr<= "0000";
rptr<="0000";
red <= '0';
elsif(clk_DIV(21)'event and clk_DIV(21)='1')then   ---0 for simulation and 21 for implementation
if (en ='1')then
if(w='1')then
if (wptr< "1111")then
mem(conv_integer(wptr)) <= datain;
wptr<= wptr +1;
else
red <= '1';
end if;
else 
if(rptr<wptr)then
red <= '0';
dataout<= mem(conv_integer(rptr));
rptr<= rptr+1;
else
red <= '1';
dataout<= "00000000";
end if;
end if;
 end if;
end if;
end process;
end Behavioral;