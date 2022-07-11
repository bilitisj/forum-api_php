-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le :  lun. 11 juil. 2022 à 10:03
-- Version du serveur :  5.7.23
-- Version de PHP :  7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `forum`
--

-- --------------------------------------------------------

--
-- Structure de la table `ticket`
--

CREATE TABLE `ticket` (
  `id_ticket` int(10) UNSIGNED NOT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `message` text NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `id_origin` varchar(30) NOT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `ticket`
--

INSERT INTO `ticket` (`id_ticket`, `tag`, `message`, `date`, `time`, `id_origin`, `id_user`) VALUES
(1, 'meteo', 'Fait-il beau ?', '2022-07-11', '13:24:14', '', 2),
(2, 'meteo', 'Oui', '2022-07-11', '16:00:00', '1', 3),
(3, 'meteo', 'treès beau', '2022-07-11', '13:00:00', '1', 2);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `ticket_user`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `ticket_user` (
`id_ticket` int(10) unsigned
,`tag` varchar(50)
,`message` text
,`date` date
,`time` time
,`id_origin` varchar(30)
,`id_user` int(11)
,`id_us` int(10) unsigned
,`user_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id_user` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id_user`, `name`, `password`) VALUES
(2, 'Pierre', '112'),
(3, 'Bili', '111');

-- --------------------------------------------------------

--
-- Structure de la vue `ticket_user`
--
DROP TABLE IF EXISTS `ticket_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ticket_user`  AS  select `ticket`.`id_ticket` AS `id_ticket`,`ticket`.`tag` AS `tag`,`ticket`.`message` AS `message`,`ticket`.`date` AS `date`,`ticket`.`time` AS `time`,`ticket`.`id_origin` AS `id_origin`,`ticket`.`id_user` AS `id_user`,`user`.`id_user` AS `id_us`,`user`.`name` AS `user_name` from (`ticket` left join `user` on((`ticket`.`id_user` = `user`.`id_user`))) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id_ticket`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id_ticket` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
