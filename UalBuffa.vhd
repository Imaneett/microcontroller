
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UALBuffers is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           Buf_A_in : in STD_LOGIC_VECTOR (3 downto 0);
     
           Buf_B_in : in STD_LOGIC_VECTOR (3 downto 0);
	   CE_Buf_A : in STD_LOGIC;
	   CE_Buf_B : in STD_LOGIC;
	   Buf_A_out : out STD_LOGIC_VECTOR (3 downto 0);
           Buf_B_out : out STD_LOGIC_VECTOR (3 downto 0);

           Buf_SR_IN_R_out : out STD_LOGIC);
end UALBuffers;

architecture UALBuffers_Arch of UALBuffers is
begin
    BufAProc : process (reset, clk, CE_Buf_A)
    begin
        if reset = '1' then
            Buf_A_out <= (others => '0'); 
        elsif (rising_edge(clk) and CE_Buf_A = '1') then
            Buf_A_out <= Buf_A_in;
        end if;
    end process;
    SRProc : process(reset, clk, Buf_A_out, Buf_B_out)
    begin
	if reset = '1' then
	Buf_SR_IN_R_out <= '0';
	elsif (rising_edge(clk)) then
	Buf_SR_IN_R_out <= Buf_A_out(3) or Buf_B_out(3);
	end if;
    end process;
    

end UALBuffers_Arch;
