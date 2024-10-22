library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_256_gcm_enc is
end tb_serpent_256_gcm_enc;

architecture behavior of tb_serpent_256_gcm_enc is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_reset     :  std_logic := '0';
    signal in_key_wr    :  std_logic;
    signal in_data_wr   :  std_logic;
    signal in_data      :  std_logic_vector (767 downto 0);  --magistrala danych wejsciowych
    signal in_key       :  std_logic_vector (255 downto 0);
    signal in_IV        :  std_logic_vector (95 downto 0);
    signal in_A         :  std_logic_vector (159 downto 0);
    signal out_data     :  std_logic_vector (767 downto 0);  --magistrala danych wyjsciowych
    signal out_tag      :  std_logic_vector (127 downto 0);

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_256_gcm_enc port map(in_clk, in_reset, in_key_wr, in_data_wr,  in_data, out_data);
    process
        
    begin
        --proba szyfrowania dwoch blokow przerwana resetem
        wait for 10 ns;
        in_data_wr <= '1';
        in_key_wr <= '1';
        in_data <= x"08000F101112131415161718191A1B1C691D3EE909D7F54167FD1CA0B5D769081F2BDE1AEE655FDBAB80BD5295AE6BE7F0761E8DCD3D000176D457EDE20106D7CD0DF0761E8DCD3D88E54C2A76D457ED00000000000000000000000000000000";
        wait for 10 ns;
        in_data_wr <= '0';
        in_key_wr <= '0';
        in_data <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        wait for 330 ns;
        wait for 60 ns;
        in_data_wr <= '1';
        in_data <= x"1D1E1F202122232425262728292A2B2C691D3EE909D7F54167FD1CA0B5D769081F2BDE1AEE655FDBAB80BD5295AE6BE7F0761E8DCD3D000176D457EDE20106D7CD0DF0761E8DCD3D88E54C2A76D457ED00000000000000000000000000000000";
        wait for 10 ns;
        in_data_wr <= '0';
        in_data <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        wait for 150 ns;
        --testowanie resetu
        in_reset <= '1';
        wait for 10 ns;
        if(out_data(767 downto 640) = x"00000000000000000000000000000000") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;
        in_reset <= '0';


        --szyfrowanie dwoch blokow
        wait for 10 ns;
        in_data_wr <= '1';
        in_key_wr <= '1';
        in_data <= x"08000F101112131415161718191A1B1C691D3EE909D7F54167FD1CA0B5D769081F2BDE1AEE655FDBAB80BD5295AE6BE7F0761E8DCD3D000176D457EDE20106D7CD0DF0761E8DCD3D88E54C2A76D457ED00000000000000000000000000000000";
        wait for 10 ns;
        in_data_wr <= '0';
        in_key_wr <= '0';
        in_data <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        wait for 330 ns;
        wait for 60 ns;
        if(out_data(767 downto 640) = x"99B38A6A72F540AF3565D55A84D20BC1") then
            report "Cipher[1] output is correct";
        else
            report "Cipher[1]nd output is incorrect";
        end if;
        in_data_wr <= '1';
        in_data <= x"1D1E1F202122232425262728292A2B2C691D3EE909D7F54167FD1CA0B5D769081F2BDE1AEE655FDBAB80BD5295AE6BE7F0761E8DCD3D000176D457EDE20106D7CD0DF0761E8DCD3D88E54C2A76D457ED00000000000000000000000000000000";
        wait for 10 ns;
        in_data_wr <= '0';
        in_data <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        wait for 330 ns;
        wait for 60 ns;
        wait for 10 ns;
        if(out_data(767 downto 640) = x"EDFC525EC77D0C56A84E86E730AA3EC2") then
            report "Cipher[2] output is correct";
        else
            report "Cipher[2]nd output is incorrect";
        end if;

        if(out_data(639 downto 512) = x"1B62F13267880C17EED20E30B84204D4") then
            report "Tag output is correct";
        else
            report "Tag output is incorrect";
        end if;
        wait for 50 ns;

        in_reset <= '1';
        wait for 10 ns;
        in_reset <= '0';
        wait for 10 ns;
        wait for 10 ns;
        --szyforwanie jednego bloku
        in_data_wr <= '1';
        in_key_wr <= '1';
        in_data <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        in_data_wr <= '0';
        in_key_wr <= '0';
        in_data <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        wait for 330 ns;
        wait for 70 ns;
        if(out_data(767 downto 640) = x"BC2C09F0B3FC63CE17F1BE7F267E3E0A") then
            report "Cipher[1] output is correct";
        else
            report "Cipher[1]nd output is incorrect";
        end if;

        if(out_data(639 downto 512) = x"B000BFC566F0AE92BA76B1F02F42DFC4") then
            report "Tag output is correct";
        else
            report "Tag output is incorrect";
        end if;
        wait for 60 ns;
        stop;
    end process;

    
end behavior;
