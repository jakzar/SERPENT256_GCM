----------------
--Jakub Zaroda--
----------------

--modul realizujacy permutację FP z jednoczesnym przejściem na bajty ze slow

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_fp is port(
    in_data      : in std_logic_vector (127 downto 0);  --magistrala danych wejsciowych
    out_data     : out std_logic_vector (127 downto 0)  --magistrala danych wyjsciowych
);
end serpent_fp;

architecture behaviour of serpent_fp is
begin
    out_data (96) <=  in_data(96);
out_data (64) <=  in_data(97);
out_data (32) <=  in_data(98);
out_data (0) <=  in_data(99);
out_data (97) <=  in_data(100);
out_data (65) <=  in_data(101);
out_data (33) <=  in_data(102);
out_data (1) <=  in_data(103);
out_data (98) <=  in_data(104);
out_data (66) <=  in_data(105);
out_data (34) <=  in_data(106);
out_data (2) <=  in_data(107);
out_data (99) <=  in_data(108);
out_data (67) <=  in_data(109);
out_data (35) <=  in_data(110);
out_data (3) <=  in_data(111);
out_data (100) <=  in_data(112);
out_data (68) <=  in_data(113);
out_data (36) <=  in_data(114);
out_data (4) <=  in_data(115);
out_data (101) <=  in_data(116);
out_data (69) <=  in_data(117);
out_data (37) <=  in_data(118);
out_data (5) <=  in_data(119);
out_data (102) <=  in_data(120);
out_data (70) <=  in_data(121);
out_data (38) <=  in_data(122);
out_data (6) <=  in_data(123);
out_data (103) <=  in_data(124);
out_data (71) <=  in_data(125);
out_data (39) <=  in_data(126);
out_data (7) <=  in_data(127);
out_data (104) <=  in_data(64);
out_data (72) <=  in_data(65);
out_data (40) <=  in_data(66);
out_data (8) <=  in_data(67);
out_data (105) <=  in_data(68);
out_data (73) <=  in_data(69);
out_data (41) <=  in_data(70);
out_data (9) <=  in_data(71);
out_data (106) <=  in_data(72);
out_data (74) <=  in_data(73);
out_data (42) <=  in_data(74);
out_data (10) <=  in_data(75);
out_data (107) <=  in_data(76);
out_data (75) <=  in_data(77);
out_data (43) <=  in_data(78);
out_data (11) <=  in_data(79);
out_data (108) <=  in_data(80);
out_data (76) <=  in_data(81);
out_data (44) <=  in_data(82);
out_data (12) <=  in_data(83);
out_data (109) <=  in_data(84);
out_data (77) <=  in_data(85);
out_data (45) <=  in_data(86);
out_data (13) <=  in_data(87);
out_data (110) <=  in_data(88);
out_data (78) <=  in_data(89);
out_data (46) <=  in_data(90);
out_data (14) <=  in_data(91);
out_data (111) <=  in_data(92);
out_data (79) <=  in_data(93);
out_data (47) <=  in_data(94);
out_data (15) <=  in_data(95);
out_data (112) <=  in_data(32);
out_data (80) <=  in_data(33);
out_data (48) <=  in_data(34);
out_data (16) <=  in_data(35);
out_data (113) <=  in_data(36);
out_data (81) <=  in_data(37);
out_data (49) <=  in_data(38);
out_data (17) <=  in_data(39);
out_data (114) <=  in_data(40);
out_data (82) <=  in_data(41);
out_data (50) <=  in_data(42);
out_data (18) <=  in_data(43);
out_data (115) <=  in_data(44);
out_data (83) <=  in_data(45);
out_data (51) <=  in_data(46);
out_data (19) <=  in_data(47);
out_data (116) <=  in_data(48);
out_data (84) <=  in_data(49);
out_data (52) <=  in_data(50);
out_data (20) <=  in_data(51);
out_data (117) <=  in_data(52);
out_data (85) <=  in_data(53);
out_data (53) <=  in_data(54);
out_data (21) <=  in_data(55);
out_data (118) <=  in_data(56);
out_data (86) <=  in_data(57);
out_data (54) <=  in_data(58);
out_data (22) <=  in_data(59);
out_data (119) <=  in_data(60);
out_data (87) <=  in_data(61);
out_data (55) <=  in_data(62);
out_data (23) <=  in_data(63);
out_data (120) <=  in_data(0);
out_data (88) <=  in_data(1);
out_data (56) <=  in_data(2);
out_data (24) <=  in_data(3);
out_data (121) <=  in_data(4);
out_data (89) <=  in_data(5);
out_data (57) <=  in_data(6);
out_data (25) <=  in_data(7);
out_data (122) <=  in_data(8);
out_data (90) <=  in_data(9);
out_data (58) <=  in_data(10);
out_data (26) <=  in_data(11);
out_data (123) <=  in_data(12);
out_data (91) <=  in_data(13);
out_data (59) <=  in_data(14);
out_data (27) <=  in_data(15);
out_data (124) <=  in_data(16);
out_data (92) <=  in_data(17);
out_data (60) <=  in_data(18);
out_data (28) <=  in_data(19);
out_data (125) <=  in_data(20);
out_data (93) <=  in_data(21);
out_data (61) <=  in_data(22);
out_data (29) <=  in_data(23);
out_data (126) <=  in_data(24);
out_data (94) <=  in_data(25);
out_data (62) <=  in_data(26);
out_data (30) <=  in_data(27);
out_data (127) <=  in_data(28);
out_data (95) <=  in_data(29);
out_data (63) <=  in_data(30);
out_data (31) <=  in_data(31);


end behaviour;