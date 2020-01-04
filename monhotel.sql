-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Sam 10 Novembre 2018 à 21:12
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `monhotel`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`Amine`@`localhost` PROCEDURE `apresHotelInsr`(IN code_h varchar(200), IN hotel varchar(500), IN tel varchar(14), IN email varchar(30))
BEGIN
				insert into MH_COMPTE_USER_H values (code_h, 'Administrateur', code_h, hotel, email, code_h, true, tel);
			END$$

CREATE DEFINER=`Amine`@`localhost` PROCEDURE `RETIRSOMTOCAISSE`(IN CH VARCHAR(200), IN MOTIF0 VARCHAR(200),IN CR VARCHAR(200))
BEGIN 
    delete from mh_caisse where code_h like CH and code_r like CR and motif like MOTIF0;
END$$

CREATE DEFINER=`Amine`@`localhost` PROCEDURE `UPDSOMTOCAISSE`(IN CH VARCHAR(200), IN CR VARCHAR(200), IN SOM FLOAT)
BEGIN 
    update mh_caisse set somme = SOM where code_h like CH and code_r like CR and motif like 'RESERVATION';
END$$

CREATE DEFINER=`Amine`@`localhost` PROCEDURE `VRSOMTOCAISSE`(IN CH VARCHAR(200),IN CU VARCHAR(200), IN MOTIF VARCHAR(200),IN SOM FLOAT, IN CR VARCHAR(200))
BEGIN 
 IF(SOM <> 0)THEN
    insert into mh_caisse(code_h, code_r, code_u, dates, motif, somme)values(CH, CR, CU, NOW(), MOTIF, SOM);
 END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `mhrsvvue_woutfct`
--
CREATE TABLE IF NOT EXISTS `mhrsvvue_woutfct` (
`num_ch` varchar(300)
,`npid` varchar(200)
,`nom_prenom` varchar(500)
,`date_a` timestamp
,`date_d` timestamp
,`periode_ouverte` tinyint(1)
,`code_r` varchar(250)
,`date_r` timestamp
,`prix_u` float
,`pension` varchar(20)
,`nb_nuitee` int(11)
,`versement` float
,`code_h` varchar(200)
,`taxe_sj` float
,`pension_c` float
,`prc_pension` int(11)
,`cloturer` bit(1)
);
-- --------------------------------------------------------

--
-- Structure de la table `mh_action_htl`
--

CREATE TABLE IF NOT EXISTS `mh_action_htl` (
  `code_h` varchar(200) DEFAULT NULL,
  `code_u` varchar(200) DEFAULT NULL,
  `action` varchar(800) DEFAULT NULL,
  `date_opr` date DEFAULT NULL,
  `val_opr` varchar(20) DEFAULT NULL,
  KEY `fk_code_h_ACTION_HTL` (`code_h`),
  KEY `fk_code_u_ACTION_HTL` (`code_u`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `mh_agc_htl_solde`
--

CREATE TABLE IF NOT EXISTS `mh_agc_htl_solde` (
  `code_a` varchar(200) DEFAULT NULL,
  `code_h` varchar(250) DEFAULT NULL,
  `solde` float DEFAULT NULL,
  `num_vers` varchar(200) NOT NULL,
  KEY `fk_code_a_AGC_HTL_SOLDE` (`code_a`),
  KEY `fk_code_h_AGC_HTL_SOLDE` (`code_h`),
  KEY `fk_num_vers_AGC_HTL_SOLDE` (`num_vers`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `mh_agence`
--

CREATE TABLE IF NOT EXISTS `mh_agence` (
  `code_a` varchar(200) NOT NULL,
  `raison_social` varchar(500) DEFAULT NULL,
  `adresse` varchar(2000) DEFAULT NULL,
  `Commune` varchar(80) DEFAULT NULL,
  `wilaya` varchar(80) DEFAULT NULL,
  `code_postal` varchar(20) DEFAULT NULL,
  `nrc` varchar(30) DEFAULT NULL,
  `nif` varchar(50) DEFAULT NULL,
  `nai` varchar(50) DEFAULT NULL,
  `rib` varchar(100) DEFAULT NULL,
  `tel` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `mail` varchar(60) DEFAULT NULL,
  `compte` tinyint(1) DEFAULT NULL,
  `date_adaptation` date DEFAULT NULL,
  `date_contrat` date DEFAULT NULL,
  `num_contrat` varchar(30) DEFAULT NULL,
  `indice_p` int(11) DEFAULT NULL,
  `description` text,
  `parametre_gps` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`code_a`),
  UNIQUE KEY `code_a` (`code_a`),
  UNIQUE KEY `nrc` (`nrc`),
  UNIQUE KEY `num_contrat` (`num_contrat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_agence`
--

INSERT INTO `mh_agence` (`code_a`, `raison_social`, `adresse`, `Commune`, `wilaya`, `code_postal`, `nrc`, `nif`, `nai`, `rib`, `tel`, `fax`, `mail`, `compte`, `date_adaptation`, `date_contrat`, `num_contrat`, `indice_p`, `description`, `parametre_gps`) VALUES
('123456', 'nean', 'nean', 'nean', 'nean', 'nean', 'nean', 'nean', 'nean', 'nean', 'nean', 'nean', 'nean@nean.nean', 1, '2018-09-10', '2018-09-10', 'nean', 0, NULL, 'nean');

-- --------------------------------------------------------

--
-- Structure de la table `mh_caisse`
--

CREATE TABLE IF NOT EXISTS `mh_caisse` (
  `code_h` varchar(200) NOT NULL,
  `code_u` varchar(200) DEFAULT NULL,
  `motif` text NOT NULL,
  `somme` float NOT NULL,
  `code_r` varchar(200) DEFAULT NULL,
  `dates` timestamp NULL DEFAULT NULL,
  KEY `fk_code_r_mh_caisse` (`code_r`),
  KEY `fk_code_h_mh_caisse` (`code_h`),
  KEY `fk_code_u_mh_caisse` (`code_u`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_caisse`
--

INSERT INTO `mh_caisse` (`code_h`, `code_u`, `motif`, `somme`, `code_r`, `dates`) VALUES
('D3933-36368-C544B-2733', '14CC1-C7AB', 'RESERVATION', 7266.95, '166B7-50740-ED-1C91', '2018-11-04 20:59:49'),
('D3933-36368-C544B-2733', '14CC1-C7AB', 'RESERVATION', 19000, 'E195-D29B-BE7E2-148', '2018-11-04 21:04:51'),
('D3933-36368-C544B-2733', '14CC1-C7AB', 'RESERVATION', 52000, '1184-C852D-3CACC-EB', '2018-11-05 07:33:12'),
('D3933-36368-C544B-2733', '14CC1-C7AB', 'RESERVATION', 2000, '1184-C852D-3CACC-EB', '2018-11-05 07:39:07'),
('D3933-36368-C544B-2733', '14CC1-C7AB', 'RESERVATION', 17119.5, 'C35CE-2D07-2866-26A2', '2018-11-06 21:42:06'),
('D3933-36368-C544B-2733', '14CC1-C7AB', 'RESERVATION', 9660.65, '4D32-B94C9-B2A44-B', '2018-11-07 22:31:34');

-- --------------------------------------------------------

--
-- Structure de la table `mh_chambre`
--

CREATE TABLE IF NOT EXISTS `mh_chambre` (
  `code_h` varchar(200) DEFAULT NULL,
  `num_ch` varchar(300) NOT NULL,
  `nb_place` int(11) DEFAULT NULL,
  `prix` float DEFAULT NULL,
  `prc_gain_agc` int(11) DEFAULT NULL,
  `type_ch` varchar(100) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  `num_ch_App` char(20) DEFAULT NULL,
  PRIMARY KEY (`num_ch`),
  UNIQUE KEY `num_ch` (`num_ch`),
  KEY `fk_code_h_chambre` (`code_h`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_chambre`
--

INSERT INTO `mh_chambre` (`code_h`, `num_ch`, `nb_place`, `prix`, `prc_gain_agc`, `type_ch`, `visible`, `num_ch_App`) VALUES
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', 1, 7500, 20, 'Senior', 1, '101'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_102', 3, 24000, 30, 'Suite', 1, '102'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_103', 2, 5600, 10, 'Junior', 1, '103'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_104', 1, 50000, 0, 'Suite', 0, '104'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_105', 5, 14000, 10, 'Senior', 1, '105'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_106', 4, 13000, 10, 'Senior', 1, '106'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_107', 4, 13000, 10, 'Junior', 1, '107');

-- --------------------------------------------------------

--
-- Structure de la table `mh_charge_supp`
--

CREATE TABLE IF NOT EXISTS `mh_charge_supp` (
  `code_r` varchar(100) NOT NULL,
  `charge` text NOT NULL,
  `prix_ch` float NOT NULL,
  `code_h` varchar(200) DEFAULT NULL,
  `dt_chrg` timestamp NULL DEFAULT NULL,
  KEY `fk_code_r_charge_supp` (`code_r`),
  KEY `fk_code_h_charge_supp` (`code_h`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_charge_supp`
--

INSERT INTO `mh_charge_supp` (`code_r`, `charge`, `prix_ch`, `code_h`, `dt_chrg`) VALUES
('1117-E8AC2-2A484-EB', 'gateau', 2000, 'D3933-36368-C544B-2733', '2018-10-02 20:57:26'),
('1117-E8AC2-2A484-EB', 'test test', 5200, 'D3933-36368-C544B-2733', '2018-10-02 21:09:36'),
('122BC-2BE4-1C0CD-1C7E', 'test charge', 680, 'D3933-36368-C544B-2733', '2018-10-10 12:46:29'),
('E67E-13B1-49AC6-148', 'fourniture pepsi', 200, 'D3933-36368-C544B-2733', '2018-10-16 20:13:58'),
('1184-C852D-3CACC-EB', 'ka3ba Gateau', 2000, 'D3933-36368-C544B-2733', '2018-11-05 07:33:34'),
('C35CE-2D07-2866-26A2', 'ser9ou dzayer la somme fi elhakika el K$', 120000, 'D3933-36368-C544B-2733', '2018-11-06 21:51:12');

-- --------------------------------------------------------

--
-- Structure de la table `mh_clt_fct`
--

CREATE TABLE IF NOT EXISTS `mh_clt_fct` (
  `raison_sociale` varchar(200) DEFAULT NULL,
  `nrc` varchar(80) DEFAULT NULL,
  `nif` varchar(80) DEFAULT NULL,
  `nai` varchar(80) DEFAULT NULL,
  `adresse` varchar(2000) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `exonore` tinyint(1) DEFAULT NULL,
  `code_c` varchar(100) NOT NULL,
  `mail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`code_c`),
  UNIQUE KEY `code_c` (`code_c`),
  UNIQUE KEY `nrc` (`nrc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_clt_fct`
--

INSERT INTO `mh_clt_fct` (`raison_sociale`, `nrc`, `nif`, `nai`, `adresse`, `tel`, `exonore`, `code_c`, `mail`) VALUES
('test client 3', '852147955', 'aze9879876azeza52', '13214659732AAR21', 'test adresse client 3', '(0777) 777-711', 0, '2A7C6-60A8', 'amitaek@gmail.com'),
('Entreprise test', '123456789', '987654321', '147258369', 'test adresse entreprise', '(0670) 298-533', 1, '2DEA4-38BB6', 'amitaek@gmail.com'),
('test client 2', '852147963', 'aze98798763221a', '13214659732aaz5', 'test adresse client 2', '(0777) 777-777', 0, 'E5D-7B', 'a-ek@hotmail.dz');

-- --------------------------------------------------------

--
-- Structure de la table `mh_clt_s_ch`
--

CREATE TABLE IF NOT EXISTS `mh_clt_s_ch` (
  `nom_prenom` varchar(500) DEFAULT NULL,
  `date_n` date DEFAULT NULL,
  `lieu_n` varchar(500) DEFAULT NULL,
  `nationalite` varchar(200) DEFAULT NULL,
  `p_id` varchar(80) DEFAULT NULL,
  `n_p_id` varchar(200) NOT NULL DEFAULT '',
  `date_p` date DEFAULT NULL,
  `lien_p` varchar(80) DEFAULT NULL,
  `adresse` varchar(4000) DEFAULT NULL,
  `num_tel` varchar(30) DEFAULT NULL,
  `liste_noir` tinyint(1) DEFAULT NULL,
  `raison_ln` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`n_p_id`),
  UNIQUE KEY `n_p_id` (`n_p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_clt_s_ch`
--

INSERT INTO `mh_clt_s_ch` (`nom_prenom`, `date_n`, `lieu_n`, `nationalite`, `p_id`, `n_p_id`, `date_p`, `lien_p`, `adresse`, `num_tel`, `liste_noir`, `raison_ln`) VALUES
('Mohammed Elamine Mahmoudi', '1987-01-18', 'annaba', 'ALG', 'Carte national', '741852', '2018-09-04', 'eltarf', 'cité 40 lgt B-27 L-D', '(0670) 298-533', 0, ''),
('Kamel Elbouchi', '1995-01-18', 'annaba', 'ALG', 'Carte national', '9513647', '2018-09-04', 'eltarf', 'cité 40 lgt B-27 L-C', '(3367) 029-853', 0, 'saraf te3 ghabra lihoudi'),
('Test Name', '1990-02-12', 'annaba', 'ALG', 'Carte national', '95175322', '2018-09-04', 'eltarf', 'cité 40 lgt B-27 L-D', '(0667) 580-790', 0, ''),
('Test Name Other', '1990-02-12', 'annaba', 'ALG', 'Carte national', '95175388', '2018-09-04', 'eltarf', 'cité 40 lgt B-27 L-D', '(0777) 777-777', 0, ''),
('Chater Foulane', '1983-04-22', 'Tarf', 'ALG', 'Carte national', '9542117AAZ', '2018-07-05', 'Daira sidi kaci', 'TARF', '(0661) 248-993', 0, ''),
('Biskri Fouad', '1983-04-22', 'Tarf', 'ALG', 'Carte national', '9575431', '2018-07-05', 'Daira sidi kaci', 'Sidi Kaci El Tarf', '(0661) 248-993', 0, ''),
('Mohamdi Issam', '1988-07-21', 'Ben Mhidi', 'Alg', 'Permis de conduire', '9876545213', '2010-10-13', 'benMhidi', 'Eltarf', '(0657) 535-458', 0, ''),
('Amor Ben Amor', '1961-12-14', 'Alger', 'ALG', 'Autre', 'ATRES8547966', '2010-10-13', 'benMhidi', 'China town', '(0654) 125-478', 0, ''),
('Kerman Omar', '1988-07-21', 'Ben Mhidi', 'Alg', 'Permis de conduire', 'AZ654521395', '2010-10-13', 'benMhidi', 'Eltarf', '(0657) 535-552', 0, ''),
('Chakib Khalil', '1988-07-21', 'Alger', 'Alg', 'Passport', 'AZ6545295B', '2010-10-13', 'benMhidi', 'USA', '(0657) 535-136', 0, ''),
('Amar Ghol', '1962-07-21', 'Alger', 'Alg', 'Autre', 'AZ6584YT78', '2010-10-13', 'benMhidi', 'USA', '(0775) 351-365', 0, ''),
('Amar Ghol', '1962-07-21', 'Alger', 'Alg', 'Autre', 'AZ6584YTF33', '2010-10-13', 'benMhidi', 'USA', '(0775) 351-365', 0, '');

-- --------------------------------------------------------

--
-- Structure de la table `mh_compte_user_a`
--

CREATE TABLE IF NOT EXISTS `mh_compte_user_a` (
  `code_a` varchar(200) DEFAULT NULL,
  `type_user` varchar(20) DEFAULT NULL,
  `code_u` varchar(200) NOT NULL,
  `nom` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `psw` varchar(100) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `tel` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`code_u`),
  UNIQUE KEY `code_u` (`code_u`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_code_a_COMPTE_USER_A` (`code_a`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `mh_compte_user_h`
--

CREATE TABLE IF NOT EXISTS `mh_compte_user_h` (
  `code_h` varchar(200) DEFAULT NULL,
  `type_user` varchar(20) DEFAULT NULL,
  `code_u` varchar(200) NOT NULL,
  `nom` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `psw` varchar(100) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `tel` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`code_u`),
  UNIQUE KEY `code_u` (`code_u`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_code_h_COMPTE_USER_H` (`code_h`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_compte_user_h`
--

INSERT INTO `mh_compte_user_h` (`code_h`, `type_user`, `code_u`, `nom`, `email`, `psw`, `admin`, `tel`) VALUES
('D3933-36368-C544B-2733', 'Administrateur', '14CC1-C7AB', 'Mohammed ElAmine Mahmoudi', 'a-ek@hotmail.fr', '123456789', 1, '(0670) 298-533'),
('D3933-36368-C544B-2733', 'Opérateur', '37008-44B6', 'Grandi Zahia', 'a-ek@hotmail.com', '123456789', 0, '(0555) 555-555');

-- --------------------------------------------------------

--
-- Structure de la table `mh_dette_agc_htl`
--

CREATE TABLE IF NOT EXISTS `mh_dette_agc_htl` (
  `code_r` varchar(200) DEFAULT NULL,
  `code_h` varchar(200) DEFAULT NULL,
  `code_a` varchar(200) DEFAULT NULL,
  `total_ht` float DEFAULT NULL,
  `versement` float DEFAULT NULL,
  `date_rcp_v` date DEFAULT NULL,
  `num_vers` varchar(200) NOT NULL,
  KEY `fk_code_r_DETTE_AGC_HTL` (`code_r`),
  KEY `fk_code_h_DETTE_AGC_HTL` (`code_h`),
  KEY `fk_code_a_DETTE_AGC_HTL` (`code_a`),
  KEY `fk_num_vers_DETTE_AGC_HTL` (`num_vers`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `mh_hotel`
--

CREATE TABLE IF NOT EXISTS `mh_hotel` (
  `code_h` varchar(200) NOT NULL,
  `raison_social` varchar(500) DEFAULT NULL,
  `adresse` varchar(2000) DEFAULT NULL,
  `Commune` varchar(80) DEFAULT NULL,
  `wilaya` varchar(80) DEFAULT NULL,
  `code_postal` varchar(20) DEFAULT NULL,
  `nrc` varchar(30) DEFAULT NULL,
  `nif` varchar(50) DEFAULT NULL,
  `nai` varchar(50) DEFAULT NULL,
  `rib` varchar(100) DEFAULT NULL,
  `tel` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `mail` varchar(60) DEFAULT NULL,
  `compte` tinyint(1) DEFAULT NULL,
  `date_adaptation` date DEFAULT NULL,
  `date_contrat` date DEFAULT NULL,
  `num_contrat` varchar(30) DEFAULT NULL,
  `indice_p` int(11) DEFAULT NULL,
  `tva_s` tinyint(1) DEFAULT NULL,
  `pension_c` float DEFAULT NULL,
  `prc_demi_pension` int(11) DEFAULT NULL,
  `taxe_sejour` float DEFAULT NULL,
  `etoile` int(11) DEFAULT NULL,
  `description` text,
  `parametre_gps` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`code_h`),
  UNIQUE KEY `code_h` (`code_h`),
  UNIQUE KEY `nrc` (`nrc`),
  UNIQUE KEY `num_contrat` (`num_contrat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_hotel`
--

INSERT INTO `mh_hotel` (`code_h`, `raison_social`, `adresse`, `Commune`, `wilaya`, `code_postal`, `nrc`, `nif`, `nai`, `rib`, `tel`, `fax`, `mail`, `compte`, `date_adaptation`, `date_contrat`, `num_contrat`, `indice_p`, `tva_s`, `pension_c`, `prc_demi_pension`, `taxe_sejour`, `etoile`, `description`, `parametre_gps`) VALUES
('C8B0-C90C1-436AE-13', 'xwfg', 'sidi kassi W -el tarf', 'dfgdfg', 'dfgdfg', '3600', '1dfhdd', 'dsfhdfdsdfh', 'sdfdfhfd', 'sdf1111111111111111111111', '(000) 00-00-00', '(0000) 000-000', 'biskri@yaoo.fr', 0, '2018-10-16', NULL, NULL, 0, 1, 15000, 12, 100, 2, NULL, NULL),
('D3933-36368-C544B-2733', 'hotel 01', 'cité des 40 logements cartier Ramdan Ati Rue des charge w-elTarf 36000 Algerie', 'ElTarf', 'ElTarf', '36000', '1245 6543 8512 B12', '1234 5678 9510 22', '7410 0258 9630 11', '9685274123455 Banque CPA Tarf Agence 213', '(038) 30-23-56', '(0670) 298-533', 'a-ek@hotmail.fr', 1, '2018-09-05', NULL, NULL, 0, 1, 2000, 50, 300, 4, 'un hotel au bord de la mere pour juste un test', NULL);

--
-- Déclencheurs `mh_hotel`
--
DROP TRIGGER IF EXISTS `trigger_MH_HOTEL`;
DELIMITER //
CREATE TRIGGER `trigger_MH_HOTEL` AFTER UPDATE ON `mh_hotel`
 FOR EACH ROW BEGIN
                 IF(NEW.compte = true AND OLD.compte = false)THEN
		    call apresHotelInsr(NEW.code_h, NEW.raison_social, NEW.tel, NEW.mail);
                 END IF;		
                 END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `mh_pub_htl`
--

CREATE TABLE IF NOT EXISTS `mh_pub_htl` (
  `code_h` varchar(200) DEFAULT NULL,
  `indice_p` int(11) DEFAULT NULL,
  `sujet` varchar(200) DEFAULT NULL,
  `contenu` varchar(4000) DEFAULT NULL,
  `date_pub` date DEFAULT NULL,
  `validation` tinyint(1) DEFAULT NULL,
  `num_pub_j` int(11) DEFAULT NULL,
  KEY `fk_code_h_PUB_HTL` (`code_h`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `mh_reservation`
--

CREATE TABLE IF NOT EXISTS `mh_reservation` (
  `code_h` varchar(200) DEFAULT NULL,
  `num_ch` varchar(300) DEFAULT NULL,
  `code_c` varchar(100) DEFAULT NULL,
  `code_a` varchar(200) DEFAULT NULL,
  `code_u` varchar(200) DEFAULT NULL,
  `date_a` timestamp NULL DEFAULT NULL,
  `date_d` timestamp NULL DEFAULT NULL,
  `periode_ouverte` tinyint(1) DEFAULT NULL,
  `nb_nuitee` int(11) DEFAULT NULL,
  `pension` varchar(20) DEFAULT NULL,
  `prix_u` float DEFAULT NULL,
  `versement` float DEFAULT NULL,
  `etat_p` tinyint(1) DEFAULT NULL,
  `facturer` tinyint(1) DEFAULT NULL,
  `code_r` varchar(250) NOT NULL,
  `date_r` timestamp NULL DEFAULT NULL,
  `taxe_sj` float DEFAULT NULL,
  `pension_c` float DEFAULT NULL,
  `prc_pension` int(11) DEFAULT NULL,
  `cloturer` bit(1) DEFAULT b'0',
  `numCmd` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`code_r`),
  UNIQUE KEY `code_r` (`code_r`),
  KEY `fk_code_h_RESERVATION` (`code_h`),
  KEY `fk_num_ch_RESERVATION` (`num_ch`),
  KEY `fk_code_c_RESERVATION` (`code_c`),
  KEY `fk_code_a_RESERVATION` (`code_a`),
  KEY `fk_code_u_RESERVATION` (`code_u`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_reservation`
--

INSERT INTO `mh_reservation` (`code_h`, `num_ch`, `code_c`, `code_a`, `code_u`, `date_a`, `date_d`, `periode_ouverte`, `nb_nuitee`, `pension`, `prix_u`, `versement`, `etat_p`, `facturer`, `code_r`, `date_r`, `taxe_sj`, `pension_c`, `prc_pension`, `cloturer`, `numCmd`) VALUES
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_102', 'E5D-7B', NULL, '14CC1-C7AB', '2018-09-29 23:00:00', '2018-10-03 23:00:00', 0, 4, 'Demi', 24000, 110898, 1, 1, '1117-E8AC2-2A484-EB', '2018-09-30 16:14:25', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_104', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-11-04 23:00:00', '2018-11-05 23:00:00', 0, 1, 'Complette', 50000, 54000, 1, 0, '1184-C852D-3CACC-EB', '2018-11-05 07:33:12', 1, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_102', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-10-09 23:00:00', '2018-10-12 22:49:51', 0, 2, 'Demi', 24000, 58803.4, 1, 1, '122BC-2BE4-1C0CD-1C7E', '2018-10-10 12:45:48', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_103', 'E5D-7B', NULL, '14CC1-C7AB', '2018-11-03 23:00:00', '2018-11-04 23:00:00', 0, 1, 'Demi', 5600, 7266.95, 1, 1, '166B7-50740-ED-1C91', '2018-11-04 20:59:49', 1, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_102', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-10-14 23:00:00', '2018-10-15 23:00:00', 0, 1, 'Demi', 24000, 27724.5, 1, 1, '1728-99C-B26B2-EC', '2018-10-15 08:05:36', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', '2A7C6-60A8', NULL, '14CC1-C7AB', '2018-10-06 23:00:00', '2018-10-12 22:51:43', 0, 5, 'Demi', 7500, 11559.7, 1, 1, '21109-D3E71-ECDDC-1D09', '2018-10-07 19:33:54', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-09-29 23:00:00', '2018-09-30 23:00:00', 0, 1, 'Complette', 7500, 10660.6, 1, 1, '3082-34A5-B52E7-4', '2018-09-30 08:17:13', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_102', '2A7C6-60A8', NULL, '14CC1-C7AB', '2018-11-01 23:00:00', '2018-11-09 23:00:00', 0, 8, 'Demi', 24000, 232219, 1, 1, '3C285-4B7E9-2190-1DED', '2018-11-02 21:40:00', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_103', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-10-20 23:00:00', '2018-10-24 23:00:00', 0, 4, 'Demi', 5600, 26400, 1, 0, '4A71-27C3-D69AA-B', '2018-10-21 07:48:23', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', '2A7C6-60A8', NULL, '14CC1-C7AB', '2018-10-01 23:00:00', '2018-10-05 23:00:00', 0, 4, 'Demi', 7500, 28678.9, 1, 1, '4AA80-D221C-49473-1E75', '2018-10-02 20:58:02', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', '2A7C6-60A8', NULL, '14CC1-C7AB', '2018-11-06 23:00:00', '2018-11-07 23:00:00', 0, 1, 'Demi', 7500, 9660.65, 1, 1, '4D32-B94C9-B2A44-B', '2018-11-07 22:31:34', 300, 2000, 50, b'0', 'null'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-11-02 23:00:00', '2018-11-04 21:04:02', 0, 1, 'Non', 7500, 82577.6, 1, 1, 'B5071-1473-4C71-261B', '2018-11-03 16:55:29', 1, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_102', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-10-20 23:00:00', '2018-10-21 23:00:00', 0, 1, 'Demi', 24000, 25000, 1, 0, 'C213E-15892-DCEE0-269D', '2018-10-21 13:27:15', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_106', NULL, NULL, '14CC1-C7AB', '2018-11-05 23:00:00', '2018-11-06 23:00:00', 0, 1, 'Demi', 13000, 17119.5, 0, 1, 'C35CE-2D07-2866-26A2', '2018-11-06 21:42:06', 300, 2000, 50, b'0', '8541'),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-11-04 23:00:00', '2018-11-06 23:00:00', 0, 2, 'Complette', 7500, 19000, 1, 0, 'E195-D29B-BE7E2-148', '2018-11-04 21:04:51', 1, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_103', '2A7C6-60A8', NULL, '14CC1-C7AB', '2018-10-14 23:00:00', '2018-10-15 23:00:00', 0, 1, 'Demi', 5600, 7467.94, 0, 1, 'E45EA-D729-B51D-27C7', '2018-10-15 07:54:44', 200, 2000, 50, b'0', NULL),
('D3933-36368-C544B-2733', 'D3933-36368-C544B-2733_101', '2DEA4-38BB6', NULL, '14CC1-C7AB', '2018-10-15 23:00:00', '2018-10-17 23:00:00', 0, 2, 'Demi', 7500, 12500, 0, 0, 'E67E-13B1-49AC6-148', '2018-10-16 20:13:02', 200, 2000, 50, b'0', NULL);

--
-- Déclencheurs `mh_reservation`
--
DROP TRIGGER IF EXISTS `trigger_MH_RESERVATION_DLT`;
DELIMITER //
CREATE TRIGGER `trigger_MH_RESERVATION_DLT` BEFORE DELETE ON `mh_reservation`
 FOR EACH ROW BEGIN
									
									CALL RETIRSOMTOCAISSE(old.code_h, 'RESERVATION', old.code_r);
									
                                END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `trigger_MH_RESERVATION_INS`;
DELIMITER //
CREATE TRIGGER `trigger_MH_RESERVATION_INS` AFTER INSERT ON `mh_reservation`
 FOR EACH ROW BEGIN
                         IF(new.code_u IS NOT NULL)THEN
			  call VRSOMTOCAISSE(new.code_h,new.code_u, 'RESERVATION',new.versement, new.code_r);
                         END IF;
                         END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `trigger_MH_RESERVATION_UPD`;
DELIMITER //
CREATE TRIGGER `trigger_MH_RESERVATION_UPD` BEFORE UPDATE ON `mh_reservation`
 FOR EACH ROW BEGIN
				
IF(new.code_u IS NOT NULL)THEN

  
      call VRSOMTOCAISSE(new.code_h,new.code_u, 'RESERVATION',new.versement - old.versement, new.code_r);
  

END IF;
					
 END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `mh_rsvvueglobal`
--
CREATE TABLE IF NOT EXISTS `mh_rsvvueglobal` (
`num_ch` varchar(300)
,`npid` varchar(200)
,`nom_prenom` varchar(500)
,`date_a` timestamp
,`date_d` timestamp
,`code_r` varchar(250)
,`date_r` timestamp
,`numFct` varchar(60)
,`designation` text
,`type_paiement` varchar(100)
,`dates` date
,`prix_u` float
,`pension` varchar(20)
,`nb_nuitee` int(11)
,`versement` float
,`code_h` varchar(200)
,`code_c` varchar(100)
,`taxe_sj` float
,`pension_c` float
,`prc_pension` int(11)
);
-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `mh_rsv_actual`
--
CREATE TABLE IF NOT EXISTS `mh_rsv_actual` (
`code_r` varchar(250)
,`num_ch` varchar(300)
,`npid` varchar(200)
,`nom_prenom` varchar(500)
,`date_a` timestamp
,`date_d` timestamp
,`date_r` timestamp
,`code_h` varchar(200)
);
-- --------------------------------------------------------

--
-- Structure de la table `mh_rsv_fct`
--

CREATE TABLE IF NOT EXISTS `mh_rsv_fct` (
  `numFct` varchar(60) NOT NULL,
  `code_r` varchar(100) NOT NULL,
  `designation` text NOT NULL,
  `type_paiement` varchar(100) DEFAULT NULL,
  `dates` date DEFAULT NULL,
  KEY `fk_code_r_rsv_fct` (`code_r`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `mh_rsv_fct`
--

INSERT INTO `mh_rsv_fct` (`numFct`, `code_r`, `designation`, `type_paiement`, `dates`) VALUES
('D3933-36368-C544B-2733_0004/2018', '1728-99C-B26B2-EC', 'Chambre Suite N°102 pension: Demi pour, Kamel Elbouchi.', 'Espece', '2018-10-30'),
('D3933-36368-C544B-2733_0002/2018', '4A71-27C3-D69AA-B', 'Chambre Junior N°103 pension: Demi pour, Kamel Elbouchi.', 'Espece', '2018-11-02'),
('D3933-36368-C544B-2733_0003/2018', 'E67E-13B1-49AC6-148', 'Chambre Senior N°101 pension: Demi pour, Mohamdi Issam.', 'Espece', '2018-11-02'),
('D3933-36368-C544B-2733_0001/2018', 'B5071-1473-4C71-261B', 'Chambre Senior N°101 pension: Non pour, Test Name.', 'Espece', '2018-11-04'),
('D3933-36368-C544B-2733_0006/2018', 'E195-D29B-BE7E2-148', 'Chambre Senior N°101 pension: Complette pour, Test Name Other.', 'Espece', '2018-11-05'),
('D3933-36368-C544B-2733_0006/2018', '1184-C852D-3CACC-EB', 'Chambre Suite N°104 pension: Complette pour, Biskri Fouad.', 'Espece', '2018-11-05'),
('D3933-36368-C544B-2733_0007/2018', 'C213E-15892-DCEE0-269D', 'Chambre Suite N°102 pension: Demi pour, Mohammed Elamine Mahmoudi.', 'Espece', '2018-11-06'),
('D3933-36368-C544B-2733_0009/2018', '4AA80-D221C-49473-1E75', 'Chambre Senior N°101 pension: Demi pour, Mohammed Elamine Mahmoudi.', 'Espece', '2018-11-06'),
('D3933-36368-C544B-2733_0008/2018', '1117-E8AC2-2A484-EB', 'Chambre Suite N°102 pension: Demi pour, Test Name Other.', 'A terme', '2018-11-06'),
('D3933-36368-C544B-2733_0005/2018', '4D32-B94C9-B2A44-B', 'Chambre Senior N°101, Demi pension, 1 nuitée pour, Amar Ghol.', 'Virement', '2018-11-08'),
('D3933-36368-C544B-2733_0010/2018', '166B7-50740-ED-1C91', 'Chambre Junior N°103, Demi pension, 1 nuitée pour, Kamel Elbouchi; commande N°: .', 'Espece', '2018-11-08'),
('D3933-36368-C544B-2733_0012/2018', '3C285-4B7E9-2190-1DED', 'Chambre Suite N°102, Demi pension, 8 nuitée pour, Mohamdi Issam, Mohammed Elamine Mahmoudi; commande N°: .', 'A terme', '2018-11-08'),
('D3933-36368-C544B-2733_0013/2018', 'E45EA-D729-B51D-27C7', 'Chambre Junior N°103, Demi pension, 1 nuitée pour, Mohammed Elamine Mahmoudi; commande N°: .', 'A terme', '2018-11-08'),
('D3933-36368-C544B-2733_0015/2018', '21109-D3E71-ECDDC-1D09', 'Chambre Senior N°101, Demi pension, 5 nuitée pour, Kamel Elbouchi; commande N°: .', 'A terme', '2018-11-08'),
('D3933-36368-C544B-2733_0016/2018', '3082-34A5-B52E7-4', 'Chambre Senior N°101, pension Complette, 1 nuitée pour, Mohammed Elamine Mahmoudi; commande N°: .', 'Espece', '2018-11-08'),
('D3933-36368-C544B-2733_0011/2018', '122BC-2BE4-1C0CD-1C7E', 'Chambre Suite N°102, Demi pension, 2 nuitée pour, Test Name Other, Mohammed Elamine Mahmoudi; commande N°: .', 'Espece', '2018-11-08');

--
-- Déclencheurs `mh_rsv_fct`
--
DROP TRIGGER IF EXISTS `trigger_mh_rsv_fct_UPD`;
DELIMITER //
CREATE TRIGGER `trigger_mh_rsv_fct_UPD` BEFORE DELETE ON `mh_rsv_fct`
 FOR EACH ROW BEGIN
									
									update mh_reservation set code_c = null where code_r like OLD.code_r;
									
                                END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `mh_vers_details`
--

CREATE TABLE IF NOT EXISTS `mh_vers_details` (
  `code_h` varchar(200) DEFAULT NULL,
  `code_a` varchar(200) DEFAULT NULL,
  `code_u` varchar(200) DEFAULT NULL,
  `code_r` varchar(250) DEFAULT NULL,
  `montant` float DEFAULT NULL,
  `date_v` date DEFAULT NULL,
  KEY `fk_code_h_VERS_DETAILS` (`code_h`),
  KEY `fk_code_a_VERS_DETAILS` (`code_a`),
  KEY `fk_code_r_VERS_DETAILS` (`code_r`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `mh_vrs_dtl_agc`
--

CREATE TABLE IF NOT EXISTS `mh_vrs_dtl_agc` (
  `code_h` varchar(200) DEFAULT NULL,
  `code_a` varchar(200) DEFAULT NULL,
  `montant` float DEFAULT NULL,
  `date_v` date DEFAULT NULL,
  `num_vers` varchar(200) NOT NULL,
  `confirmation` tinyint(1) DEFAULT NULL,
  `type_versement` varchar(50) DEFAULT NULL,
  `pieceLink` varchar(200) DEFAULT NULL,
  UNIQUE KEY `num_vers` (`num_vers`),
  KEY `fk_code_h_VRS_DTL_AGC` (`code_h`),
  KEY `fk_code_a_VRS_DTL_AGC` (`code_a`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rsv_clt_sch`
--

CREATE TABLE IF NOT EXISTS `rsv_clt_sch` (
  `code_r` varchar(200) NOT NULL,
  `npid` varchar(200) NOT NULL,
  KEY `fk_code_r_rsv_clt_sch` (`code_r`),
  KEY `fk_npid_rsv_clt_sch` (`npid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `rsv_clt_sch`
--

INSERT INTO `rsv_clt_sch` (`code_r`, `npid`) VALUES
('3082-34A5-B52E7-4', '741852'),
('1117-E8AC2-2A484-EB', '95175388'),
('4AA80-D221C-49473-1E75', '741852'),
('21109-D3E71-ECDDC-1D09', '9513647'),
('122BC-2BE4-1C0CD-1C7E', '95175388'),
('122BC-2BE4-1C0CD-1C7E', '741852'),
('E45EA-D729-B51D-27C7', '741852'),
('1728-99C-B26B2-EC', '9513647'),
('E67E-13B1-49AC6-148', '9876545213'),
('4A71-27C3-D69AA-B', '9513647'),
('C213E-15892-DCEE0-269D', '741852'),
('3C285-4B7E9-2190-1DED', '9876545213'),
('3C285-4B7E9-2190-1DED', '741852'),
('B5071-1473-4C71-261B', '95175322'),
('166B7-50740-ED-1C91', '9513647'),
('E195-D29B-BE7E2-148', '95175388'),
('1184-C852D-3CACC-EB', '9575431'),
('C35CE-2D07-2866-26A2', 'AZ6584YTF33'),
('C35CE-2D07-2866-26A2', 'AZ6545295B'),
('C35CE-2D07-2866-26A2', '9542117AAZ'),
('4D32-B94C9-B2A44-B', 'AZ6584YTF33');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `rsv_clt_sch_vue`
--
CREATE TABLE IF NOT EXISTS `rsv_clt_sch_vue` (
`date_a` timestamp
,`date_d` timestamp
,`code_h` varchar(200)
,`npid` varchar(200)
,`code_r` varchar(250)
,`periode_ouverte` tinyint(1)
);
-- --------------------------------------------------------

--
-- Structure de la vue `mhrsvvue_woutfct`
--
DROP TABLE IF EXISTS `mhrsvvue_woutfct`;

CREATE ALGORITHM=UNDEFINED DEFINER=`Amine`@`localhost` SQL SECURITY DEFINER VIEW `mhrsvvue_woutfct` AS select `mh_reservation`.`num_ch` AS `num_ch`,`rsv_clt_sch`.`npid` AS `npid`,`mh_clt_s_ch`.`nom_prenom` AS `nom_prenom`,`mh_reservation`.`date_a` AS `date_a`,`mh_reservation`.`date_d` AS `date_d`,`mh_reservation`.`periode_ouverte` AS `periode_ouverte`,`mh_reservation`.`code_r` AS `code_r`,`mh_reservation`.`date_r` AS `date_r`,`mh_reservation`.`prix_u` AS `prix_u`,`mh_reservation`.`pension` AS `pension`,`mh_reservation`.`nb_nuitee` AS `nb_nuitee`,`mh_reservation`.`versement` AS `versement`,`mh_reservation`.`code_h` AS `code_h`,`mh_reservation`.`taxe_sj` AS `taxe_sj`,`mh_reservation`.`pension_c` AS `pension_c`,`mh_reservation`.`prc_pension` AS `prc_pension`,`mh_reservation`.`cloturer` AS `cloturer` from ((`mh_reservation` join `rsv_clt_sch`) join `mh_clt_s_ch`) where ((`mh_reservation`.`code_r` = `rsv_clt_sch`.`code_r`) and (`mh_clt_s_ch`.`n_p_id` = `rsv_clt_sch`.`npid`));

-- --------------------------------------------------------

--
-- Structure de la vue `mh_rsvvueglobal`
--
DROP TABLE IF EXISTS `mh_rsvvueglobal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`Amine`@`localhost` SQL SECURITY DEFINER VIEW `mh_rsvvueglobal` AS select `mh_reservation`.`num_ch` AS `num_ch`,`rsv_clt_sch`.`npid` AS `npid`,`mh_clt_s_ch`.`nom_prenom` AS `nom_prenom`,`mh_reservation`.`date_a` AS `date_a`,`mh_reservation`.`date_d` AS `date_d`,`mh_reservation`.`code_r` AS `code_r`,`mh_reservation`.`date_r` AS `date_r`,`mh_rsv_fct`.`numFct` AS `numFct`,`mh_rsv_fct`.`designation` AS `designation`,`mh_rsv_fct`.`type_paiement` AS `type_paiement`,`mh_rsv_fct`.`dates` AS `dates`,`mh_reservation`.`prix_u` AS `prix_u`,`mh_reservation`.`pension` AS `pension`,`mh_reservation`.`nb_nuitee` AS `nb_nuitee`,`mh_reservation`.`versement` AS `versement`,`mh_reservation`.`code_h` AS `code_h`,`mh_reservation`.`code_c` AS `code_c`,`mh_reservation`.`taxe_sj` AS `taxe_sj`,`mh_reservation`.`pension_c` AS `pension_c`,`mh_reservation`.`prc_pension` AS `prc_pension` from (((`mh_reservation` join `rsv_clt_sch`) join `mh_rsv_fct`) join `mh_clt_s_ch`) where ((`mh_reservation`.`code_r` = `rsv_clt_sch`.`code_r`) and (`mh_rsv_fct`.`code_r` = `mh_reservation`.`code_r`) and (`mh_clt_s_ch`.`n_p_id` = `rsv_clt_sch`.`npid`));

-- --------------------------------------------------------

--
-- Structure de la vue `mh_rsv_actual`
--
DROP TABLE IF EXISTS `mh_rsv_actual`;

CREATE ALGORITHM=UNDEFINED DEFINER=`Amine`@`localhost` SQL SECURITY DEFINER VIEW `mh_rsv_actual` AS select `mhrsvvue_woutfct`.`code_r` AS `code_r`,`mhrsvvue_woutfct`.`num_ch` AS `num_ch`,`mhrsvvue_woutfct`.`npid` AS `npid`,`mhrsvvue_woutfct`.`nom_prenom` AS `nom_prenom`,`mhrsvvue_woutfct`.`date_a` AS `date_a`,`mhrsvvue_woutfct`.`date_d` AS `date_d`,`mhrsvvue_woutfct`.`date_r` AS `date_r`,`mhrsvvue_woutfct`.`code_h` AS `code_h` from `mhrsvvue_woutfct` where ((`mhrsvvue_woutfct`.`date_a` <= now()) and (`mhrsvvue_woutfct`.`date_d` >= now()));

-- --------------------------------------------------------

--
-- Structure de la vue `rsv_clt_sch_vue`
--
DROP TABLE IF EXISTS `rsv_clt_sch_vue`;

CREATE ALGORITHM=UNDEFINED DEFINER=`Amine`@`localhost` SQL SECURITY DEFINER VIEW `rsv_clt_sch_vue` AS select `mh_reservation`.`date_a` AS `date_a`,`mh_reservation`.`date_d` AS `date_d`,`mh_reservation`.`code_h` AS `code_h`,`rsv_clt_sch`.`npid` AS `npid`,`mh_reservation`.`code_r` AS `code_r`,`mh_reservation`.`periode_ouverte` AS `periode_ouverte` from (`mh_reservation` join `rsv_clt_sch`) where (`mh_reservation`.`code_r` = `rsv_clt_sch`.`code_r`);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `mh_action_htl`
--
ALTER TABLE `mh_action_htl`
  ADD CONSTRAINT `fk_code_h_ACTION_HTL` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_u_ACTION_HTL` FOREIGN KEY (`code_u`) REFERENCES `mh_compte_user_h` (`code_u`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_agc_htl_solde`
--
ALTER TABLE `mh_agc_htl_solde`
  ADD CONSTRAINT `fk_code_a_AGC_HTL_SOLDE` FOREIGN KEY (`code_a`) REFERENCES `mh_agence` (`code_a`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_h_AGC_HTL_SOLDE` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_num_vers_AGC_HTL_SOLDE` FOREIGN KEY (`num_vers`) REFERENCES `mh_vrs_dtl_agc` (`num_vers`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_caisse`
--
ALTER TABLE `mh_caisse`
  ADD CONSTRAINT `fk_code_h_mh_caisse` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_r_mh_caisse` FOREIGN KEY (`code_r`) REFERENCES `mh_reservation` (`code_r`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_u_mh_caisse` FOREIGN KEY (`code_u`) REFERENCES `mh_compte_user_h` (`code_u`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_chambre`
--
ALTER TABLE `mh_chambre`
  ADD CONSTRAINT `fk_code_h_chambre` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_charge_supp`
--
ALTER TABLE `mh_charge_supp`
  ADD CONSTRAINT `fk_code_h_charge_supp` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_r_charge_supp` FOREIGN KEY (`code_r`) REFERENCES `mh_reservation` (`code_r`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_compte_user_a`
--
ALTER TABLE `mh_compte_user_a`
  ADD CONSTRAINT `fk_code_a_COMPTE_USER_A` FOREIGN KEY (`code_a`) REFERENCES `mh_agence` (`code_a`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_compte_user_h`
--
ALTER TABLE `mh_compte_user_h`
  ADD CONSTRAINT `fk_code_h_COMPTE_USER_H` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_dette_agc_htl`
--
ALTER TABLE `mh_dette_agc_htl`
  ADD CONSTRAINT `fk_code_a_DETTE_AGC_HTL` FOREIGN KEY (`code_a`) REFERENCES `mh_agence` (`code_a`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_h_DETTE_AGC_HTL` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_r_DETTE_AGC_HTL` FOREIGN KEY (`code_r`) REFERENCES `mh_reservation` (`code_r`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_num_vers_DETTE_AGC_HTL` FOREIGN KEY (`num_vers`) REFERENCES `mh_vrs_dtl_agc` (`num_vers`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_pub_htl`
--
ALTER TABLE `mh_pub_htl`
  ADD CONSTRAINT `fk_code_h_PUB_HTL` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_reservation`
--
ALTER TABLE `mh_reservation`
  ADD CONSTRAINT `fk_code_a_RESERVATION` FOREIGN KEY (`code_a`) REFERENCES `mh_agence` (`code_a`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_c_RESERVATION` FOREIGN KEY (`code_c`) REFERENCES `mh_clt_fct` (`code_c`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_h_RESERVATION` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_u_RESERVATION` FOREIGN KEY (`code_u`) REFERENCES `mh_compte_user_h` (`code_u`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_num_ch_RESERVATION` FOREIGN KEY (`num_ch`) REFERENCES `mh_chambre` (`num_ch`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_rsv_fct`
--
ALTER TABLE `mh_rsv_fct`
  ADD CONSTRAINT `fk_code_r_rsv_fct` FOREIGN KEY (`code_r`) REFERENCES `mh_reservation` (`code_r`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_vers_details`
--
ALTER TABLE `mh_vers_details`
  ADD CONSTRAINT `fk_code_a_VERS_DETAILS` FOREIGN KEY (`code_a`) REFERENCES `mh_agence` (`code_a`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_h_VERS_DETAILS` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_r_VERS_DETAILS` FOREIGN KEY (`code_r`) REFERENCES `mh_reservation` (`code_r`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `mh_vrs_dtl_agc`
--
ALTER TABLE `mh_vrs_dtl_agc`
  ADD CONSTRAINT `fk_code_a_VRS_DTL_AGC` FOREIGN KEY (`code_a`) REFERENCES `mh_agence` (`code_a`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_code_h_VRS_DTL_AGC` FOREIGN KEY (`code_h`) REFERENCES `mh_hotel` (`code_h`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Contraintes pour la table `rsv_clt_sch`
--
ALTER TABLE `rsv_clt_sch`
  ADD CONSTRAINT `fk_code_r_rsv_clt_sch` FOREIGN KEY (`code_r`) REFERENCES `mh_reservation` (`code_r`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
