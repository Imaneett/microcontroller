

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity UALSELROUTE is
    Port ( 
     EL_ROUTE : in STD_LOGIC_VECTOR(3 downto 0);
     S : inout STD_LOGIC_VECTOR(7 downto 0);
     A : inout STD_LOGIC_VECTOR(3 downto 0);
     B : inout STD_LOGIC_VECTOR(3 downto 0);
     Buf_A_out : inout STD_LOGIC_VECTOR(3 downto 0);
	Buf_B_out : inout STD_LOGIC_VECTOR(3 downto 0);
	Mem_1_out : inout STD_LOGIC_VECTOR(3 downto 0);
	Mem_2_out : inout STD_LOGIC_VECTOR(3 downto 0);
	CE_Buf_A : out STD_LOGIC;
	CE_Buf_B : out STD_LOGIC;
	CE_Mem_1 : out STD_LOGIC;
	CE_Mem_2 : out STD_LOGIC;   
  A completer
    );
end UALSELROUTE;

architecture UALSELROUTE_Arch of UALSELROUTE is

begin

    MySelRouteProc : process (SEL_ROUTE, S, A, B, Buf_A_out, Buf_B_out, Mem_1_out, Mem_2_out)
    begin
        case SEL_ROUTE is

            when "0001" => -- Stockage de MEM_CACHE_1 dans Buffer_A (4 bits de poids faibles)
                CE_Buf_A <= '1'; CE_Buf_B <= '0'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
                Buf_A_in <= Mem_1_out(3 downto 0); Buf_B_in <= (others => '0'); 
                Mem_1_In <= (others => '0'); Mem_2_In <= (others => '0');
                
           when "0010" => -- Stockage de S dans Buffer_A (4 bits de poids faibles)
               CE_Buf_A <= '1'; CE_Buf_B <= '0'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
                Buf_A_in <= S(3 downto 0); Buf_B_in <= (others => '0');
                Mem_1_In <= (others => '0');
                Mem_2_In <= (others => '0');
           when "0011" => -- Stockage de A dans Buffer_A (4 bits de poids faibles)
	       CE_Buf_A <= '1'; CE_Buf_B <= '0'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
	       Buf_A_in <= A; Buf_B_in <= (others => '0'); 
               Mem_1_In <= (others => '0');
               Mem_2_In <= (others => '0');

          when "0100" => -- Stockage de B dans Buffer_A (4 bits de poids faibles)
	    CE_Buf_A <= '1'; CE_Buf_B <= '0'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
	    Buf_A_in <= B; Buf_B_in <= (others => '0'); 
            Mem_1_In <= (others => '0'); 
            Mem_2_In <= (others => '0');
         when "0101" => -- Stockage de Buf_A_out dans Buffer_B (4 bits de poids faibles)
            CE_Buf_A <= '0'; CE_Buf_B <= '1'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
            Buf_A_in <= (others => '0'); Buf_B_in <= Buf_A_out;
            Mem_1_In <= (others => '0');
            Mem_2_In <= (others => '0');
        when "0110" => -- Stockage de Buf_B_out dans Buffer_A (4 bits de poids faibles)
           CE_Buf_A <= '1'; CE_Buf_B <= '0'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
           Buf_A_in <= Buf_B_out; Buf_B_in <= (others => '0');
           Mem_1_In <= (others => '0');
           Mem_2_In <= (others => '0');
       when "0111" => -- Stockage de Mem_1_out dans Buffer_B (4 bits de poids faibles)
	CE_Buf_A <= '0'; CE_Buf_B <= '1'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
	Buf_A_in <= (others => '0'); Buf_B_in <= Mem_1_out;
	Mem_1_In <= (others => '0');
	Mem_2_In <= (others => '0');

      when "1000" => -- Stockage de Mem_2_out dans Buffer_A (4 bits de poids faibles)
	CE_Buf_A <= '1'; CE_Buf_B <= '0'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
	Buf_A_in <= Mem_2_out; Buf_B_in <= (others => '0');
	Mem_1_In <= (others => '0');
	Mem_2_In <= (others => '0');
     when others =>
        CE_Buf_A <= '0'; CE_Buf_B <= '0'; CE_Mem_1 <= '0'; CE_Mem_2 <= '0';
        Buf_A_in <= (others => '0'); Buf_B_in <= (others => '0');
        Mem_1_In <= (others => '0'); 
        Mem_2_In <= (others => '0');
  

    end case;
    end process;

end UALSELROUTE_Arch;
