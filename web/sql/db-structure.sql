--Tipos de datos en Mysql
--Numericos: bit, boolean, smallint,int, float, double, real
--Cadena: char, varchar, tinytext,text, longtext
--fecha: date, datetime, timestamp time, year 
--json: json


-- --------------------------------------------------------

--
-- 			Estructura de tabla para la tabla `users`
--

-- --------------------------------------------------------

CREATE TABLE `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` smallint(4) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(100) NOT NULL,
  `realName` varchar(100) NOT NULL,
  `surname` varchar(100) NOT NULL,
  `web` varchar(100) NOT NULL,
  `validate` varchar(20) NOT NULL,
  `counter` int(100) NOT NULL,
  `date` varchar(500) NOT NULL,
  `view` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `observations` longtext NOT NULL,
  UNIQUE KEY `ID` (`id`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci; 


--
-- BHorrando la tabla `usuarios`
-- Para poder borrar la tabla users primero tendrás que borrar las tablas game, gameUsers y multimedia que tienen el id como clave foranea
-- Drop table users;
 
--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `users` (`id`, `name`, `password`, `role`, `email`, `realName`, `surname`, `web`, `validate`, `counter`, `date`, `view`, `token`, `observations`) VALUES
(1, 'nobody', '1c558dfd6f4148767d40386fa7b59c18e3b8627e', 3, 'nobody@audiotours.tipolisto.es', '', '', '', '1', 0, '', 1, '', ''),
(2, 'adeline', '1c558dfd6f4148767d40386fa7b59c18e3b8627e', 3, 'adeline@audiotours.tipolisto.es', '', '', '', '1', 0, '', 1, '', ''),
(3, 'ada', '1c558dfd6f4148767d40386fa7b59c18e3b8627e', 3, 'ada@audiotours.tipolisto.es', '', '', '', '1', 0, '', 1, '', ''),
(4, 'ennrique', '8b08a87c980d75add89798754899184c196b1a50', 3, 'lucas@audiotours.com', '', '', '', '1', 0, '', 1, '', ''),
(5, 'kike', '58746b54a4c7e856562f17e9bc6d2a07861da891', 1, 'kikemadrigal@audiotours.com', 'Enrique', 'Madrigal', 'tipolisto.es', '1', 0, '11/01/2018', 1, '', '41434143'),
(6, 'simón', '58746b54a4c7e856562f17e9bc6d2a07861da891', 1, 'simon@audiotours.com', ' ', ' ', ' ', '1', 0, '29/04/2022', 1, '', 'clave generada por defecto');

--delete from users;

--
-- Modificando la estructura de la tabla
--
--ALTER TABLE `usuarios`
--  ADD PRIMARY KEY (`idusuario`),
--  ADD UNIQUE KEY `ID` (`idusuario`);
--
--ALTER TABLE `usuarios`
--  MODIFY `idusuario` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;
--COMMIT;



-- --------------------------------------------------------

--
-- 			Estructura de tabla para la tabla `tours`
--

-- --------------------------------------------------------
--Antes de crear esta tabla tendrás que crear la tabla image, theme, group y users 
--El type es museo, playa, parque, etc
--Media el el archivo de audio mp3
--Image es la imagen de cabacera
--Datos obtenidos de google maps: tourist attractions
--type: mualla, castillo, museo, etc
--media
create table `tours` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar (255) NOT NULL,
	`coordinates` POINT NOT NULL,
  `latitude` varchar(20) NOT NULL,
  `longitude` varchar(20) NOT NULL,
	`type` varchar (255) default 'Without type',
	`media` int (10) default 1,
  `image` int (10) default 1,
  `blogUrl` varchar(255) default 'Without type',
  `address` varchar(255),
  `phone` varchar(255),
  `web` varchar(255),
  `description` longtext  default 'Without description',
	`date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `userId` int(10) default 1,
	UNIQUE KEY `ID` (`id`),
	PRIMARY KEY `pkId` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;


INSERT INTO `tours` (`id`, `name`, `coordinates`, `latitude`, `longitude`, `type`, `media`, `image`, `blogUrl`, `description`, `date`, `userId`) VALUES
(1, 'Sin tour', 0x00000000010100000000000000000000000000000000000000,'0','0', 'Sin tipo', 1, 1, 'Sin blog url', 'Sin descripcion', '2023-02-20 18:57:10', 1);




  --FOREIGN KEY `fkMediaId` (`media`) REFERENCES audios(`id`) ON DELETE CASCADE,
  --FOREIGN KEY `fkImageId` (`image`) REFERENCES images(`id`) ON DELETE CASCADE





-- --------------------------------------------------------







--
-- 			Estructura de tabla para la tabla `types`
--
-- para el tipo de formato de los medias
-- --------------------------------------------------------


create table `mediaTypes`(
	`id` int(10)  NOT NULL AUTO_INCREMENT,
	`name` varchar(255),
	`date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	UNIQUE KEY `ID` (`id`),
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `mediaTypes` (`id`, `name`, `date`) VALUES
(1, 'empty', '2023-03-01 21:28:48'),
(2, 'png', '2023-03-01 21:28:48'),
(3, 'jpg', '2023-03-01 21:29:06'),
(4, 'jpeg', '2023-03-01 21:29:06'),
(5, 'gif', '2023-03-01 21:29:31'),
(6, 'mp3', '2023-03-01 21:29:31');








-- --------------------------------------------------------

--
-- 			Estructura de tabla para la tabla `images`
--Esta tabla no puede existir si no se crea antes la tabla tours y el usuario 1 ya que necesita tener un lugar
--Esta tabla no puede existir si no se crea antes la tabla users e insertados los usuarios
--Esta tabla no puede existir si no se crea antes la tabla mediaTypes y insertados los mediaTypes
--revisa los insert para ver los media que existen
--Con el campo isHeader le decimos que es una imagen de cabecera y que no se puede borrar, solo se borra cuando borramos el tour

-- --------------------------------------------------------


CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50),
  `path` varchar(100),
  `isHeader` bit default 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `typeId` int(10),
  `userId` int(10),
  `tourId` int(10) default 1,
  UNIQUE KEY `ID` (`id`),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`typeId`) REFERENCES mediaTypes(`id`),
  FOREIGN KEY (`userId`) REFERENCES users(`id`),
  FOREIGN KEY (`tourId`) REFERENCES tours(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
  

INSERT INTO `images` (`id`, `name`, `path`, `isHeader`, `date`, `typeId`, `userId`, `tourId`) VALUES
(1, 'withoutImage.png', 'media', '1', '2023-00-00 00:00:00', 1, 1, 1);








-- --------------------------------------------------------

--
-- 			Estructura de tabla para la tabla `audios`
--Esta tabla no puede existir si no se crea antes la tabla tours ya que necesita tener un lugar
--Esta tabla no puede existir si no se crea antes la tabla users
--Esta tabla no puede existir si no se crea antes la tabla types
--revisa los insert para ver los media que existen
--Con el campo isHeader le decimos que es una imagen de cabecera y que no se puede borrar, solo se borra cuando borramos el tour
-- --------------------------------------------------------


CREATE TABLE `audios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50),
  `path` varchar(100),
  `isHeader` bit default 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `typeId` int(10),
  `userId` int(10),
  `tourId` int(10) default 1,
  UNIQUE KEY `ID` (`id`),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`typeId`) REFERENCES mediaTypes(`id`),
  FOREIGN KEY (`userId`) REFERENCES users(`id`),
  FOREIGN KEY (`tourId`) REFERENCES tours(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
  

INSERT INTO `audios` (`id`, `name`, `path`, `isHeader`, `date`, `typeId`, `userId`, `tourId`) VALUES
(1, 'withoutAudio.mp3', 'media', '1', '2023-00-00 00:00:00', 6, 1, 1);








-- --------------------------------------------------------

--
-- 			Estructura de tabla para la tabla `comments`
--
-- puede ser un museo, un teatro, una ciudad, etc
-- --------------------------------------------------------


create table `coments`(
	`id` int(10)  NOT NULL AUTO_INCREMENT,
	`name` varchar(255),
	`father` varchar(255),
	`date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	UNIQUE KEY `ID` (`id`),
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

---------------
  --Borrado
----------------


--drop table media;
--drop table tours;
--drop table users;


---------------
  --CReación
---------------

--crete users;
--insert users
--create tours;
--inserts tour 1
--create media;