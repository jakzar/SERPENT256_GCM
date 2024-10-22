library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_keys is
end tb_serpent_keys;

architecture behavior of tb_serpent_keys is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_data      :  std_logic_vector (255 downto 0);
    signal out_key_0     :  std_logic_vector (127 downto 0);
    signal out_key_1     :  std_logic_vector (127 downto 0);
    signal out_key_2     :  std_logic_vector (127 downto 0);
    signal out_key_3     :  std_logic_vector (127 downto 0);
    signal out_key_4     :  std_logic_vector (127 downto 0);
    signal out_key_5     :  std_logic_vector (127 downto 0);
    signal out_key_6     :  std_logic_vector (127 downto 0);
    signal out_key_7     :  std_logic_vector (127 downto 0);
    signal out_key_8     :  std_logic_vector (127 downto 0);
    signal out_key_9     :  std_logic_vector (127 downto 0);
    signal out_key_10     :  std_logic_vector (127 downto 0);
    signal out_key_11     :  std_logic_vector (127 downto 0);
    signal out_key_12    :  std_logic_vector (127 downto 0);
    signal out_key_13     :  std_logic_vector (127 downto 0);
    signal out_key_14     :  std_logic_vector (127 downto 0);
    signal out_key_15     :  std_logic_vector (127 downto 0);
    signal out_key_16     :  std_logic_vector (127 downto 0);
    signal out_key_17     :  std_logic_vector (127 downto 0);
    signal out_key_18     :  std_logic_vector (127 downto 0);
    signal out_key_19     :  std_logic_vector (127 downto 0);
    signal out_key_20     :  std_logic_vector (127 downto 0);
    signal out_key_21     :  std_logic_vector (127 downto 0);
    signal out_key_22     :  std_logic_vector (127 downto 0);
    signal out_key_23     :  std_logic_vector (127 downto 0);
    signal out_key_24     :  std_logic_vector (127 downto 0);
    signal out_key_25     :  std_logic_vector (127 downto 0);
    signal out_key_26     :  std_logic_vector (127 downto 0);
    signal out_key_27     :  std_logic_vector (127 downto 0);
    signal out_key_28     :  std_logic_vector (127 downto 0);
    signal out_key_29     :  std_logic_vector (127 downto 0);
    signal out_key_30     :  std_logic_vector (127 downto 0);
    signal out_key_31     :  std_logic_vector (127 downto 0);
    signal out_key_32     :  std_logic_vector (127 downto 0);

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_keys port map(in_data, out_key_0, out_key_1, out_key_2, out_key_3, out_key_4, out_key_5, out_key_6, out_key_7, out_key_8, out_key_9, out_key_10, out_key_11, out_key_12, out_key_13, out_key_14, out_key_15, out_key_16, out_key_17, out_key_18, out_key_19, out_key_20, out_key_21, out_key_22, out_key_23, out_key_24, out_key_25, out_key_26, out_key_27, out_key_28, out_key_29, out_key_30, out_key_31, out_key_32);
    process
        
    begin
        wait for 10 ns;
        wait for 10 ns;
        in_data<=x"2BD6459F82C5B300952C49104881FF482BD6459F82C5B300952C49104881FF48";

        wait for 10 ns;
        wait for 10 ns;
        stop;
    end process;

end behavior;
