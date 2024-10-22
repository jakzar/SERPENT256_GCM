----------------
--Jakub Zaroda--
----------------

--modul realizujacy skrzynke podstawieniowa s7

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_sub_key_5_fun_inv is port(
    in_data      : in std_logic_vector (127 downto 0);
    out_data     : out std_logic_vector (127 downto 0)
);
end serpent_sub_key_5_fun_inv;

architecture behaviour of serpent_sub_key_5_fun_inv is
    signal after_ip : std_logic_vector (127 downto 0);
    signal before_fp : std_logic_vector (127 downto 0);
begin
    ip: entity work.serpent_ip port map(in_data, after_ip);

    s0: entity work.serpent_sbox5_inv port map(after_ip(127 downto 124), before_fp(127 downto 124));
    s1: entity work.serpent_sbox5_inv port map(after_ip(123 downto 120), before_fp(123 downto 120));
    s2: entity work.serpent_sbox5_inv port map(after_ip(119 downto 116), before_fp(119 downto 116));
    s3: entity work.serpent_sbox5_inv port map(after_ip(115 downto 112), before_fp(115 downto 112));
    s4: entity work.serpent_sbox5_inv port map(after_ip(111 downto 108), before_fp(111 downto 108));
    s5: entity work.serpent_sbox5_inv port map(after_ip(107 downto 104), before_fp(107 downto 104));
    s6: entity work.serpent_sbox5_inv port map(after_ip(103 downto 100), before_fp(103 downto 100));
    s7: entity work.serpent_sbox5_inv port map(after_ip(99 downto 96), before_fp(99 downto 96));
    s8: entity work.serpent_sbox5_inv port map(after_ip(95 downto 92), before_fp(95 downto 92));
    s9: entity work.serpent_sbox5_inv port map(after_ip(91 downto 88), before_fp(91 downto 88));
    s10: entity work.serpent_sbox5_inv port map(after_ip(87 downto 84), before_fp(87 downto 84));
    s11: entity work.serpent_sbox5_inv port map(after_ip(83 downto 80), before_fp(83 downto 80));
    s12: entity work.serpent_sbox5_inv port map(after_ip(79 downto 76), before_fp(79 downto 76));
    s13: entity work.serpent_sbox5_inv port map(after_ip(75 downto 72), before_fp(75 downto 72));
    s14: entity work.serpent_sbox5_inv port map(after_ip(71 downto 68), before_fp(71 downto 68));
    s15: entity work.serpent_sbox5_inv port map(after_ip(67 downto 64), before_fp(67 downto 64));
    s16: entity work.serpent_sbox5_inv port map(after_ip(63 downto 60), before_fp(63 downto 60));
    s17: entity work.serpent_sbox5_inv port map(after_ip(59 downto 56), before_fp(59 downto 56));
    s18: entity work.serpent_sbox5_inv port map(after_ip(55 downto 52), before_fp(55 downto 52));
    s19: entity work.serpent_sbox5_inv port map(after_ip(51 downto 48), before_fp(51 downto 48));
    s20: entity work.serpent_sbox5_inv port map(after_ip(47 downto 44), before_fp(47 downto 44));
    s21: entity work.serpent_sbox5_inv port map(after_ip(43 downto 40), before_fp(43 downto 40));
    s22: entity work.serpent_sbox5_inv port map(after_ip(39 downto 36), before_fp(39 downto 36));
    s23: entity work.serpent_sbox5_inv port map(after_ip(35 downto 32), before_fp(35 downto 32));
    s24: entity work.serpent_sbox5_inv port map(after_ip(31 downto 28), before_fp(31 downto 28));
    s25: entity work.serpent_sbox5_inv port map(after_ip(27 downto 24), before_fp(27 downto 24));
    s26: entity work.serpent_sbox5_inv port map(after_ip(23 downto 20), before_fp(23 downto 20));
    s27: entity work.serpent_sbox5_inv port map(after_ip(19 downto 16), before_fp(19 downto 16));
    s28: entity work.serpent_sbox5_inv port map(after_ip(15 downto 12), before_fp(15 downto 12));
    s29: entity work.serpent_sbox5_inv port map(after_ip(11 downto 8), before_fp(11 downto 8));
    s30: entity work.serpent_sbox5_inv port map(after_ip(7 downto 4), before_fp(7 downto 4));
    s31: entity work.serpent_sbox5_inv port map(after_ip(3 downto 0), before_fp(3 downto 0));

    fp: entity work.serpent_fp port map(before_fp, out_data);
end behaviour;