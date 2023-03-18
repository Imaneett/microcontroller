
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
ibrary UNISIM;
use UNISIM.VComponents.all;

entity UALSELOUT is
    Port ( 
     SEL_OUT : in STD_LOGIC_VECTOR(1 downto 0);
     S : in STD_LOGIC_VECTOR(7 downto 0);
     Mem_1_out : in STD_LOGIC_VECTOR(7 downto 0);
     Mem_2_out : in STD_LOGIC_VECTOR(7 downto 0);
     Res_out : out STD_LOGIC_VECTOR(7 downto 0)
 );

end UALSELOUT;

architecture UALSELOUT_Arch of UALSELOUT is

begin

    MySelRouteProc : process (SEL_OUT, S, Mem_1_out, Mem_2_out)
    begin
        case SEL_OUT is
            when "01" => -- RES_OUT = MEM_CACHE_1
                Res_out <= Mem_1_out;
           when "10" => -- RES_OUT = MEM_CACHE_2
             Res_out <= Mem_2_out;
           when others => -- RES_OUT = S
             Res_out <= S;
        end case;
    end process;

end UALSELOUT_Arch;
