-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-10-2022 a las 04:39:30
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `taller_android`
--
CREATE DATABASE IF NOT EXISTS `taller_android` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `taller_android`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `color` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `color`) VALUES
(1, 'backend', 'rojo'),
(2, 'frontend', 'azul'),
(3, 'fullstack', 'naranja'),
(4, 'desktop', 'morado'),
(5, 'mobile', 'verde');


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lenguajes`
--

CREATE TABLE `lenguajes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `img` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `lenguajes`
--

INSERT INTO `lenguajes` (`id`, `nombre`, `img`) VALUES
(1, 'Java', 700004),
(2, 'C++', 700001),
(3, 'C#', 700000),
(4, 'JS', 700006),
(5, 'PHP', 700007),
(6, 'Python', 700002);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `repositorio` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `lenguaje_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id`, `nombre`, `descripcion`, `repositorio`, `fecha_creacion`, `fecha_fin`, `usuario_id`, `categoria_id`, `lenguaje_id`) VALUES
(4, 'test desde app', 'descripcion', NULL, '2022-10-17 00:49:42', NULL, 18, 5, 6),
(5, 'test desde app', 'descripcion', NULL, '2022-10-17 00:50:42', NULL, 18, 5, 6),
(6, 'test desde app', 'descripcion', NULL, '2022-10-17 00:50:49', NULL, 18, 5, 6),
(7, 'test desde app', 'descripcion', NULL, '2022-10-17 00:51:04', NULL, 2, 3, 6),
(8, 'test desde app', 'descripcion', NULL, '2022-10-17 00:51:18', NULL, 2, 4, 6),
(9, 'test desde app', 'descripcion', NULL, '2022-10-17 00:51:22', NULL, 2, 4, 2),
(10, 'test desde app', 'descripcion', NULL, '2022-10-17 00:51:26', NULL, 2, 4, 1),
(11, 'test desde app', 'descripcion', NULL, '2022-10-17 00:51:39', NULL, 2, 4, 4),
(12, 'test desde app', 'descripcion', NULL, '2022-10-17 00:51:39', NULL, 2, 4, 4),
(13, 'test', 'test', NULL, '2022-10-17 00:56:13', NULL, 2, 3, 3),
(14, 'test', 'test', NULL, '2022-10-17 00:56:19', NULL, 2, 1, 5),
(15, 'prueba', 'prueba', NULL, '2022-10-18 01:57:32', NULL, 18, 1, 1),
(16, 'prueba', 'prueba', NULL, '2022-10-18 01:57:39', NULL, 18, 2, 1),
(17, 'prueba', 'prueba', NULL, '2022-10-18 01:57:43', NULL, 18, 4, 1),
(18, 'prueba', 'prueba', NULL, '2022-10-18 01:57:45', NULL, 18, 5, 1),
(19, 'prueba', 'prueba', NULL, '2022-10-18 01:57:51', NULL, 18, 5, 3),
(20, 'prueba', 'prueba', NULL, '2022-10-18 01:57:57', NULL, 18, 5, 4),
(21, 'prueba', 'prueba', NULL, '2022-10-18 01:58:02', NULL, 18, 4, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `clave` text NOT NULL,
  `rol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombres`, `apellidos`, `email`, `clave`, `rol`) VALUES
(2, 'Alan', 'Brito', 'alan.brito@gmail.com', '$2b$12$uvevlFqhbrTa2YSv7OkCQupYGkkWsEa/f8F21SihNBn', 'admin'),
(18, 'juan pablo', 'gavilan fuentealba', 'jp@gmail.com', '$2b$12$./uRg/MuzBpxhAKQdvMBoewVsZFkHDOGbh.oyzB5mjeYcXsQidK2G', 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lenguajes`
--
ALTER TABLE `lenguajes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_usuario_id_proyectos` (`usuario_id`),
  ADD KEY `categorias_categoria_id_proyectos` (`categoria_id`),
  ADD KEY `lenguajes_lenguaje_id_proyectos` (`lenguaje_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `lenguajes`
--
ALTER TABLE `lenguajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD CONSTRAINT `categorias_categoria_id_proyectos` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `lenguajes_lenguaje_id_proyectos` FOREIGN KEY (`lenguaje_id`) REFERENCES `lenguajes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuarios_usuario_id_proyectos` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
