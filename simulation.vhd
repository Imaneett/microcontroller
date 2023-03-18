library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity TB_UALCore is
Port ( );
end TB_UALCore;

architecture TB_UALCore_Arch of TB_UALCore is

    component UALCore 
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           SR_IN_L : in STD_LOGIC;
           SR_IN_R : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           SR_OUT_L : out STD_LOGIC;
           SR_OUT_R : out STD_LOGIC;
           SEL_FCT : in STD_LOGIC_VECTOR (3 downto 0));
    end component;
    signal My_A, My_B, My_SEL_FCT : std_logic_vector(3 downto 0); 
    signal My_S : std_logic_vector(7 downto 0);
    signal My_SR_IN_L, My_SR_IN_R, My_SR_OUT_L, My_SR_OUT_R : std_logic;

    --Compteur pour la simulation
    signal my_cpt_sim : std_logic_vector(14 downto 0) := (others => '0'); -- Initialisation du compteur ‡ 0
 --   signal my_cpt_sim : std_logic_vector(14 downto 0) := "011110000000000";

begin

    MyComponentUnderTest : UALCore
    port map (
        A => My_A,
        B => My_B,
        SR_IN_L => My_SR_IN_L, 
	  SR_IN_R => My_SR_IN_R,
	  SEL_FCT => My_SEL_FCT
    );

    -- Affectation des vecteurs de test depuis le compteur
    My_A <= my_cpt_sim(3 downto 0);
    My_B <= my_cpt_sim(7 downto 4);
    My_SR_IN_L <= my_cpt_sim(8);
    My_SR_IN_R <= my_cpt_sim(9);
    My_SEL_FCT <= my_cpt_sim(13 downto 10);
    
    -- Simulation process -> indentation du compteur
    MySimProc : process
    begin
        WAIT FOR 1 ns;
        if (my_cpt_sim(14) = '1') then 
            WAIT;
        else
            my_cpt_sim <=  my_cpt_sim + 1;
        end if;
    end process;

end TB_UALCore_Arch;
