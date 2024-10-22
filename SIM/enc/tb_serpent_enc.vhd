library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_enc is
end tb_serpent_enc;

architecture behavior of tb_serpent_enc is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_reset : std_logic := '0';
    signal in_data      :  std_logic_vector (127 downto 0);
    signal in_key      :  std_logic_vector (255 downto 0);
    signal out_data      :  std_logic_vector (127 downto 0);

    signal in_key_wr  : std_logic;
    signal in_data_wr  : std_logic;

    signal out_busy  : std_logic;

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_enc port map(in_clk, in_reset, in_key_wr, in_data_wr, in_data, in_key, out_data, out_busy);
    process
        
    begin
        wait for 10 ns;
        wait for 10 ns;
        --Set 4 Vector 0
        in_key_wr <= '1';
        in_data_wr <= '1';
        in_key<=x"000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F";
        in_data<=x"00112233445566778899AABBCCDDEEFF";

        wait for 10 ns;
        in_key_wr <= '0';
        in_data_wr <= '0';
        in_key <= (others => '0');
        in_data <= (others => '0');
        wait for 350 ns;

        if(out_data = x"2868B7A2D28ECD5E4FDEFAC3C4330074") then
            report "Encryption is correct";
        else
            report "Encryption is incorrect";
        end if;
        --Set 3 vector 255
        in_key_wr <= '1';
        in_data_wr <= '1';
        in_key<=x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
        in_data<=x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
        wait for 10 ns;
        in_key_wr <= '0';
        in_data_wr <= '0';
        in_key <= (others => '0');
        in_data <= (others => '0');
        wait for 350 ns;
        

        --Test resetu
        if(out_data = x"6AC7579D9377845A816CA6D758F3FEFF") then
            report "Encryption is correct";
        else
            report "Encryption is incorrect";
        end if;
        in_key_wr <= '1';
        in_data_wr <= '1';
        in_key<=x"000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F";
        in_data<=x"00112233445566778899AABBCCDDEEFF";

        wait for 10 ns;
        in_key_wr <= '0';
        in_data_wr <= '0';
        in_key <= (others => '0');
        in_data <= (others => '0');
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        in_reset<='1';
        wait for 10 ns;
        in_reset<='0';
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        if(out_data = x"00000000000000000000000000000000") then
            report "Reset works correct";
        else
            report "Reset works incorrect";
        end if;
        wait for 10 ns;
        --Set 4 Vector 0
        in_key_wr <= '1';
        in_data_wr <= '1';
        in_key<=x"000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F";
        in_data<=x"00112233445566778899AABBCCDDEEFF";

        wait for 10 ns;
        in_key_wr <= '0';
        in_data_wr <= '0';
        in_key <= (others => '0');
        in_data <= (others => '0');
        wait for 350 ns;
        
        if(out_data = x"2868B7A2D28ECD5E4FDEFAC3C4330074") then
            report "Encryption is correct";
        else
            report "Encryption is incorrect";
        end if;

        --Set 4 Vector 1
        in_key_wr <= '1';
        in_data_wr <= '1';
        in_key<=x"2BD6459F82C5B300952C49104881FF482BD6459F82C5B300952C49104881FF48";
        in_data<=x"EA024714AD5C4D84EA024714AD5C4D84";

        wait for 10 ns;
        in_key_wr <= '0';
        in_data_wr <= '0';
        in_key <= (others => '0');
        in_data <= (others => '0');
        wait for 350 ns;
        if(out_data = x"3E507730776B93FDEA661235E1DD99F0") then
            report "Encryption is correct";
        else
            report "Encryption is incorrect";
        end if;
        wait for 10 ns;
        stop;
    end process;

end behavior;
