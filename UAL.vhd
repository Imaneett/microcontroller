library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity UALCore is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           SR_IN_L : in STD_LOGIC;
           SR_IN_R : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           SR_OUT_L : out STD_LOGIC;
           SR_OUT_R : out STD_LOGIC;
           SEL_FCT : in STD_LOGIC_VECTOR (3 downto 0)
	);
end UALCore;

architecture UALCore_Arch of UALCore is

    signal My_A, My_B, My_SEL_FCT : std_logic_vector(3 downto 0); 
    signal My_S : std_logic_vector(7 downto 0);
    signal My_SR_IN_L, My_SR_IN_R, My_SR_OUT_L, My_SR_OUT_R : std_logic;
 
begin

MyUALCore_Proc : process (A, B, SR_IN_L, SR_IN_R, SEL_FCT)
    variable My_S_Var, My_A_Var, My_B_Var, My_SR_IN_R_Var : std_logic_vector (7 downto 0); 
begin
    case SEL_FCT is
        when "0001" =>  --S = A + B addition binaire avec SR_IN_R comme retenue d'entrÈe
            	My_A_Var(7 downto 4) <= (others => A(3));
		My_A_Var(3 downto 0) <= A;
		My_B_Var(7 downto 4) <= (others => B(3));
		My_B_Var(3 downto 0) <= B;
		My_SR_IN_R_Var(7 downto 1) <= (others => '0');
		My_SR_IN_R_Var(0) <= SR_IN_R;

		S <= My_S(6 downto 0);
		SR_OUT_R <= My_S(7);

		My_S_Var = My_A_Var + My_B_Var + My_SR_IN_R_Var;

		SR_OUT_L <= '0';

        when "0010" => -- S = A + B addition binaire sans retenue d'entrÈe
            	My_A_Var(7 downto 4) <= (others => A(3));
		My_A_Var(3 downto 0) <= A;
		My_B_Var(7 downto 4) <= (others => B(3));
		My_B_Var(3 downto 0) <= B;
		
		S <= My_S(6 downto 0);
		SR_OUT_R <= My_S(7);

		My_S_Var = My_A_Var + My_B_Var;

		SR_OUT_L <= '0';

        when "0011" => -- S = A - B soustraction binaire
           	My_A_Var(7 downto 4) <= (others => A(3));
		My_A_Var(3 downto 0) <= A;
		My_B_Var(7 downto 4) <= (others => B(3));
		My_B_Var(3 downto 0) <= B;
		
		S <= My_S_Var(6 downto 0);
		SR_OUT_R <= My_S_Var(7);

		My_S_Var = My_A_Var - My_B_Var;

		SR_OUT_L <= '0';
    
        when "0100" => -- S = A * B multiplication binaire
           	S <= A * B; 
            	SR_OUT_L <= '0';
		SR_OUT_R <= '0';

        when "0101" => -- S = A | SR_OUT_L = 0 et SR_OUT_R = 0
            	S(7 downto 4) <= (others => '0');
            	S(3 downto 0) <= A;

		SR_OUT_L <= '0';
		SR_OUT_R <= '0';

        when "0110" => -- S = B | SR_OUT_L = 0 et SR_OUT_R = 0
            	S(7 downto 4) <= (others => '0');
            	S(3 downto 0) <= B;

		SR_OUT_L <= '0';
		SR_OUT_R <= '0';

        when "0111" => -- S = not A | SR_OUT_L = 0 et SR_OUT_R = 0
            	S(7 downto 4) <= (others => '0');
            	S(3 downto 0) <= not A;

		SR_OUT_L <= '0';
		SR_OUT_R <= '0';

        when "1000" => -- S = not B | SR_OUT_L = 0 et SR_OUT_R = 0
            	S(7 downto 4) <= (others => '0');
            	S(3 downto 0) <= not B;

		SR_OUT_L <= '0';
		SR_OUT_R <= '0';

        when "1001" => -- S = A and B | SR_OUT_L = 0 et SR_OUT_R = 0
            	S(7 downto 4) <= (others => '0');
            	S(3 downto 0) <= A and B;

		SR_OUT_L <= '0';
		SR_OUT_R <= '0';

        when "1010" => -- S = A or B | SR_OUT_L = 0 et SR_OUT_R = 0
            	S(7 downto 4) <= (others => '0');
            	S(3 downto 0) <= A or B;

		SR_OUT_L <= '0';
		SR_OUT_R <= '0';

        when "1011" => -- S = A xor B | SR_OUT_L = 0 et SR_OUT_R = 0
            	S(7 downto 4) <= (others => '0');
            	S(3 downto 0) <= A xor B;

		SR_OUT_L <= '0';
		SR_OUT_R <= '0';

	when "1100" => -- S = DÈc. droite A (avec SR_IN_L) | SR_IN_L pour le bit entrant et SR_OUT_R pour le bit sortant
        	S(7 downto 4) <= (others => '0');
        	S(3) <= SR_IN_L;
		S(2 downto 0) <= A(3 downto 1);

		SR_OUT_L <= '0';
		SR_OUT_R <= A(0);

        when "1101" => -- S = DÈc. gauche A (avec SR_IN_R) | SR_IN_R pour le bit entrant et SR_OUT_L pour le bit sortant
		S(7 downto 4) <= (others => '0');
		S(3 downto 1) <= A(2 downto 0);
		S(0) <= SR_IN_R;

		SR_OUT_L <= A(3);
		SR_OUT_R <= '0';

        when "1110" => -- S = DÈc. droite B (avec SR_IN_L) | SR_IN_L pour le bit entrant et SR_OUT_R pour le bit sortant
		S(7 downto 4) <= (others => '0');
		S(3) <= SR_IN_L;
		S(2 downto 0) <= B(3 downto 1);

		S_OUT_L <= '0';
		S_OUT_R <= B(0);

        when "1111" => -- S = DÈc. gauche B (avec SR_IN_R) | SR_IN_R pour le bit entrant et SR_OUT_L pour le bit sortant
		S(7 downto 4) <= (others => '0');
		S(3 downto 1) <= B(2 downto 0);
		S(0) <= SR_IN_R;

		SR_OUT_L <= B(3);
		SR_OUT_R <= '0';

        when others => nop (no operation) S = 0 | SR_OUT_L = 0 et SR_OUT_R = 0
		S <= (others => '0');
		SR_OUT_L <= '0';
		SR_OUT_R <= '0';


    end case;
end process;

end UALCore_Arch;
