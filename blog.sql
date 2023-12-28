-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2023 at 11:29 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `authorities`
--

CREATE TABLE `authorities` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `authority` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authorities`
--

INSERT INTO `authorities` (`id`, `username`, `authority`) VALUES
(1, 'irena', 'ROLE_admin'),
(2, 'janko', 'ROLE_admin'),
(3, 'jovan', 'ROLE_admin'),
(4, 'marija', 'ROLE_admin'),
(5, 'marko', 'ROLE_admin'),
(6, 'petar', 'ROLE_user'),
(7, 'ivana', 'ROLE_user'),
(42, 'luka', 'ROLE_user');

-- --------------------------------------------------------

--
-- Table structure for table `Blog`
--

CREATE TABLE `Blog` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `idCategory` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `userUsername` varchar(45) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  `views` bigint(20) DEFAULT NULL,
  `important` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Blog`
--

INSERT INTO `Blog` (`id`, `date`, `idCategory`, `name`, `userUsername`, `description`, `text`, `views`, `important`, `enabled`) VALUES
(1, '2023-11-10', 10, 'Company Analysis and Detailed Insight', 'irena', 'Company analysis is a thorough assessment of a company\'s performance for deep understanding of its current state and future potential. It involves a thorough assessment of various aspects, including financial stability, market presence, and competitive advantage, to uncover valuable insights', 'As research geeks, the only thing we love more than writing about the latest insight trends, methodologies and technologies is reading about them. Fortunately for us, the insight community is full of fascinating and diverse opinions to explore. There is almost always something new to discover, to the point that it can almost be a challenge to keep up with the pace of change. ', 58, 1, 1),
(2, '2023-05-07', 3, 'Our Health Experts Help You Stay Healthy', 'ivana', 'It’s one thing to follow a diet or exercise program, but it’s another to take a magnifying glass to the lifestyle choices of leading health experts.', 'It’s one thing to follow a diet or exercise program, but it’s another to take a magnifying glass to the lifestyle choices of leading health experts.', 16, 0, 1),
(4, '2023-12-06', 11, 'Local Female Hockey Team Won the Game', 'janko', 'Three major sports teams play in the Steel City: the Pittsburgh Pirates, the Penguins, and the Steelers — all men’s teams. But news broke this summer that organizers plan to launch a new professional women’s hockey league — The North American league.', 'Field hockey (or simply hockey) is a team sport structured in standard hockey format, in which each team plays with eleven players in total, made up of ten outfield players and a goalkeeper. Teams must move a hockey ball around a pitch by hitting it with a hockey stick towards the rival team\'s shooting circle and then into the goal. The match is won by the team that scores the most goals. Matches are played on grass, watered turf, artificial turf, or indoor boarded surface.', 20, 1, 1),
(5, '2023-05-14', 4, 'It\'s Important to Go to Bed on Time', 'marko', 'Consistency is the key to your circadian rhythm. If you usually sleep at 10 pm, then your brain is trained to release melatonin around this time, to help your body, your mind, and your senses to start feeling drowsy and sleepy, ensuring you have a good night sleep and better sleep.', 'It\'s essential to go to sleep before midnight, adds Dr. Allison Brager, a neurobiologist with expertise in sleep and circadian rhythms, as this “optimizes time spent in restorative non-REM [rapid eye movement] sleep.”', 1, 1, 0),
(6, '2023-04-02', 4, 'Start Your Day With a Morning Exercise', 'jovan', 'The following five benefits might just outweigh the earlier wake-up call.', 'Exercising in the morning is very important for your body and mind.', 1, 1, 0),
(7, '2023-03-02', 1, 'Latest BLockbuster Hits You Must See', 'janko', 'Movie theaters are officially back. As the cinematic offerings slowly return to the big screen compared to the streaming services and various digital rental retailers, we’re here to sort out what’s actually the best bang for your buck at the box office.', 'Discover the top, most popular movies available now! Across theaters, streaming, and on-demand, these are the movies Rotten Tomatoes users are checking out at this very moment, including Killers of the Flower Moon (see Martin Scorsese movies ranked), Old Dads, and The Burial.', 4, 1, 1),
(8, '2023-02-02', 7, 'Latest Fashion Trends for Autumn This Year', 'petar', 'Coats from Khaite, Gucci and Erdem [and] turtleneck dresses from Tove, Carolina Herrera and Bottega Veneta are some of autumn/winter 2023\'s must-haves. We\'re excited to be kicking off this trend with Maximilian Davis\'s debut collection at Ferragamo for last season\'s collections.\" I really can\'t fault this H&M blazer.', 'Once September hits every year, fashion lovers feel a subtle change in the air—hardly noticeable, but recognizable nonetheless. Suddenly, putting on shorts just doesn’t feel quite as enticing, and every time a closet is opened, their eye lingers a little longer on the blazer that hasn’t seen wear in a few months. We know what’s happening: Fall fashion is suddenly rumbling under the surface, patiently waiting for a sub-70 day to make its glorious debut for the year. ', 2, 1, 1),
(9, '2023-01-02', 2, 'Top List of the Latest Music Hits on Radio', 'marko', 'The Billboard Hot 100 singles chart tracks the most popular songs every week from Friday to Thursday based on a combination of their sales, online streams (audio and video), and radio airplay. Below is the list of every song that came out on top in 2023, updated weekly as each new chart is announced.', 'Oh FLO, I love them dearly. The girl group – who if you don’t know are 2023’s answer to Destiny’s Child – has enough panache, charisma and swagger they could give Kelly Rowland a run for her money. This feminine anthem, featuring a booty-shaking verse from the OG Missy Elliot, telling you to ‘get your hair done, get your nails did’ has a no-shits-given attitude that’s dripping in confidence. Listen to this tune as you brush past your ex in the street with a fresh manicure and take no notice.', 31, 1, 1),
(10, '2023-06-02', 5, 'How They Won an Important Dancing Contest', 'marija', 'It\'s important for dancers to see others compete, and to be able to recognize other great talent on the stage regardless of who ends up with what trophies.', 'If you’ve never been to a dance competition, they are quite the sight to behold!', 2, 1, 1),
(11, '2023-08-02', 8, 'Plant Based Food Diet That Will Help You Lose Your Weight', 'marija', 'Plant-based diets can help you lose weight and keep it off because they are packed with fiber, which helps fill you up, without adding extra calories. Aim for 40 grams of fiber a day, which is easy to do when you move vegetables, fruits, whole grains, and beans to the center of your plate.', 'For years, plant-based diets have enjoyed rising popularity for their emphasis on sustainability and possible wellness benefits, such as improved heart health, lower risk of diabetes, and even longer life, as various research suggests. Another potential advantage of eating a diet high in plants: weight loss. If dropping a pants size or two is one of your personal goals, a growing body of research suggests replacing animal products with plants could promote a healthier weight.', 3, 0, 1),
(12, '2023-08-28', 6, 'Tips and Tricks on How to Fix Your Bike Quickly', 'janko', 'I\'m here to tell you that basic DIY bicycle repair and maintenance is not that hard. Really! The key is to tackle one task at a time so it\'s not overwhelming, and then to just practice, practice, practice on your own bike. Bikes are actually pretty simple machines once you get to know them.', 'Bikes provide a fun, healthy, and sustainable mode of transportation, whether you are commuting to work or meeting up with friends for a group ride. Routine bike maintenance and proper repairs will keep your bike running in top condition. Below you will find some of the most common bike repairs—from fixing a broken chain to adjusting your handlebars.', 11, 1, 1),
(13, '2023-08-21', 8, 'Firecracker Vegan Lettuce Wraps', 'marija', 'Firecracker Lettuce Wraps that are happily vegan – with crispy tofu bits, saucy brown rice noodles, and a creamy sesame sauce.', 'Firecracker Lettuce Wraps – I see you with your browned crispy tofu bits, your sticky brown rice noodles, your delicate lettuce leaves, and your creamy umami sauce. I see you and I love you and I want you.', 2, 1, 1),
(66, '2023-11-08', NULL, 'Top 10 France Travel Destinations', 'irena', 'For more than two decades, France has reigned as the world’s most popular tourist destination, receiving 82 million foreign tourists annual. Travelers from all over the world are drawn to France’s sophisticated culture, exquisite cuisine, fine wines, romantic chateaux and picturesque countryside.', 'Try the D-Day landing beaches in Normandy on for size or the Germanic culture in the Alsace region. Visit the Loire Valley for castles and vineyards, or Brittany for its earthy Celtic culture. For more wine, there’s the globally renowned Bordeaux region – famous for you know what. There are the French Alps, with Europe’s highest peak Mont Blanc to visit. In the south, there’s the endless charm of the French Riviera, including Saint-Tropez. There’s a lot to fit in, but here are the best places to visit in France.At the core of Marseille is its old port, Vieux Port. Dominated by two historic forts, this bustling harbor is lined with waterfront cafes, shops and bars. At the end of the harbor is the Quai des Belges where visitors can view luxury yachts, ferry boats and fishermen auctioning off their catch at the daily fish market.At the core of Marseille is its old port, Vieux Port. Dominated by two historic forts, this bustling harbor is lined with waterfront cafes, shops and bars. At the end of the harbor is the Quai des Belges where visitors can view luxury yachts, ferry boats and fishermen auctioning off their catch at the daily fish market.At the core of Marseille is its old port, Vieux Port. Dominated by two historic forts, this bustling harbor is lined with waterfront cafes, shops and bars. At the end of the harbor is the Quai des Belges where visitors can view luxury yachts, ferry boats and fishermen auctioning off their catch at the daily fish market.At the core of Marseille is its old port, Vieux Port. Dominated by two historic forts, this bustling harbor is lined with waterfront cafes, shops and bars. At the end of the harbor is the Quai des Belges where visitors can view luxury yachts, ferry boats and fishermen auctioning off their catch at the daily fish market.', 125, 1, 1),
(74, '2023-11-08', 4, 'Fall: The season of cozy, delicious, wisdom-inducing rediscovery', 'irena', ' The many elements of autumn either intrinsically deliver happiness or trigger memories of past joy from which we can keep taking bites, as from a freshly baked apple pie.', 'When I lived in Songpa-gu, I enjoyed going to Seoul\'s parks and walking on the crunchy leaves. I saw so many wonderful sights at Gyeongbok Palace, Biwon, Changdeok Palace, and Unhyeon Palace. Often, traditional rites and ceremonies occurred, with locals and tourists crowding in alike to see them. But the gentle breeze and inviting stroll through Insa-dong and other kinds of places made the days seem simply delightful.', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Blog_Image`
--

CREATE TABLE `Blog_Image` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Blog_Image`
--

INSERT INTO `Blog_Image` (`id`, `blog_id`, `image_id`) VALUES
(1, 5, 27),
(2, 9, 28),
(4, 2, 2),
(5, 4, 3),
(6, 6, 4),
(7, 7, 5),
(8, 8, 6),
(9, 10, 7),
(10, 11, 8),
(11, 12, 9),
(12, 13, 10),
(13, 66, 11),
(14, 74, 12),
(43, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Blog_Tag`
--

CREATE TABLE `Blog_Tag` (
  `id` int(11) NOT NULL,
  `id_blog` int(11) DEFAULT NULL,
  `id_tag` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Blog_Tag`
--

INSERT INTO `Blog_Tag` (`id`, `id_blog`, `id_tag`) VALUES
(4, 4, 14),
(5, 5, 12),
(6, 5, 13),
(7, 6, 15),
(8, 7, 16),
(9, 8, 17),
(10, 9, 18),
(11, 10, 16),
(12, 11, 19),
(13, 12, 20),
(18, 2, 20);

-- --------------------------------------------------------

--
-- Table structure for table `Category`
--

CREATE TABLE `Category` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Category`
--

INSERT INTO `Category` (`id`, `name`, `description`, `image_id`, `position`) VALUES
(1, 'Entertainment', 'Entairtainment industry news...', 14, 2),
(2, 'Music', 'Music blogs are a great place to learn about new music trends', 15, 3),
(3, 'Health and fitness', 'These are websites that seek to provide information intended to help people learn about or make decisions that are considered better for thei', 16, 5),
(4, 'Lifestyle', 'There seems to be a lot of confusion about what a lifestyle blog is. Simply put, it\'s a website documenting one person\'s life and their personal interests and everyday existence. Th', 17, 7),
(5, 'Dancing', 'Dancing blog...', 18, 6),
(6, 'Tips and Tricks', 'Tips and tricks...', 19, 9),
(7, 'Fashion', 'A fashion blog can cover many topics, such as specific items of clothing and accessories, beauty tips, trends in various apparel markets (haute couture, porter, etc.), celebrity fashion choices, and street fashion trends.', 20, 4),
(8, 'Food', 'Food blog...', 21, 8),
(10, 'Business', 'A business blog...', 22, 1),
(11, 'Sports', 'Sports blog...', 23, 10);

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `commentUsername` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `idBlog` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `commentUsername`, `date`, `name`, `email`, `text`, `idBlog`, `enabled`) VALUES
(49, 'irena', '2023-11-06', 'Irena', 'irena@gmail.com', 'Thank you for your useful pieces of advice!', 66, 1),
(50, 'ivana', '2023-11-06', 'Ivana', 'ivana@gmail.com', 'I loved Nice! I absolutely agree with your recommendations!', 66, 1),
(59, 'jovan', '2023-11-08', 'Jovan', 'jovan@gmail.com', 'What a lovely article! I enjoyed reading it.', 74, 1),
(63, 'petar', '2023-11-15', 'Petar', 'petar@gmail.com', 'France is a great country to visit! ', 66, 1),
(71, 'marko', '2023-12-08', 'Marko', 'marko@gmail.com', 'Thank you for a great insight!', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Image`
--

CREATE TABLE `Image` (
  `id` int(11) NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Image`
--

INSERT INTO `Image` (`id`, `imageUrl`, `fileName`) VALUES
(1, '/images/blog/1/Company-Analysis.jpg', 'Company-Analysis.jpg'),
(2, '/images/blog/2/health-and-wellbeing_low-res.jpg', 'health-and-wellbeing_low-res.jpg'),
(3, '/images/blog/4/PA-55875259 - 1266.jpg', 'PA-55875259 - 1266.jpg'),
(4, '/images/blog/6/Fitness.jpg', 'Fitness.jpg'),
(5, '/images/blog/7/featured.jpg', 'featured.jpg'),
(6, '/images/blog/8/best_online_clothes_shops.jpg', 'best_online_clothes_shops.jpg'),
(7, '/images/blog/10/6329d957edbe7f00190f048f.jpg', '6329d957edbe7f00190f048f.jpg'),
(8, '/images/blog/11/Vegan-Food_Plant-based_Diet_iStock-1301035781-scaled-e1649342230379.jpg', 'Vegan-Food_Plant-based_Diet_iStock-1301035781-scaled-e1649342230379.jpg'),
(9, '/images/blog/12/94897980-3ebd-11ea-94d0-0a08a20865b8.jpg', '94897980-3ebd-11ea-94d0-0a08a20865b8.jpg'),
(10, '/images/blog/13/Fotolia_194879681_S-768x513.jpg', 'Fotolia_194879681_S-768x513.jpg'),
(11, '/images/blog/66/nice-france-population.pic-1.jpg', 'nice-france-population.pic-1.jpg'),
(12, '/images/blog/74/fall.jpg', 'fall.jpg'),
(14, '/images/category/1/entairtainment.jpg', 'entairtainment.jpg'),
(15, '/images/category/2/musicstreaming.jpg', 'musicstreaming.jpg'),
(16, '/images/category/3/healthandfitness.jpg', 'healthandfitness.jpg'),
(17, '/images/category/4/lifestyle.jpg', 'lifestyle.jpg'),
(18, '/images/category/5/dance-silhouettes-966x543.jpg', 'dance-silhouettes-966x543.jpg'),
(19, '/images/category/6/tipsandtrickss.png', 'tipsandtrickss.png'),
(20, '/images/category/7/fashiontrendssketch.jpg', 'fashiontrendssketch.jpg'),
(21, '/images/category/8/table-filled-with-large-variety-of-food-shot-from-royalty-free-image-1659038707.jpg', 'table-filled-with-large-variety-of-food-shot-from-royalty-free-image-1659038707.jpg'),
(22, '/images/category/10/aboutbusiness.jpg', 'aboutbusiness.jpg'),
(23, '/images/category/11/sports.jpeg', 'sports.jpeg'),
(24, '/images/slide/1/Affordablemarketingideasforyoursmallbusiness_featuredimage.4adf827d-1.jpg', 'Affordablemarketingideasforyoursmallbusiness_featuredimage.4adf827d-1.jpg'),
(27, '/images/blog/5/Sleep-in-Older-Adults.jpeg', 'Sleep-in-Older-Adults.jpeg'),
(28, '/images/blog/9/getty_626660256_2000108620009280158_388846.jpg', 'getty_626660256_2000108620009280158_388846.jpg'),
(40, '/images/users/irena/irena.png', 'irena.png'),
(41, '/images/users/ivana/beautiful-blonde-woman-portrait-smiling-face_53876-137593.jpg', 'beautiful-blonde-woman-portrait-smiling-face_53876-137593.jpg'),
(42, '/images/users/janko/photo-1564564244660-5d73c057f2d2.jpg', 'photo-1564564244660-5d73c057f2d2.jpg'),
(43, '/images/users/jovan/white-background-being-hard-impress_273609-57668.jpg', 'white-background-being-hard-impress_273609-57668.jpg'),
(44, '/images/users/luka/luka.jpg', 'luka.jpg'),
(45, '/images/users/marija/dressed-casually-looking-with-satisfaction_176420-15187.jpg', 'dressed-casually-looking-with-satisfaction_176420-15187.jpg'),
(46, '/images/users/marko/young-bearded-man-with-striped-shirt_273609-5677.jpg', 'young-bearded-man-with-striped-shirt_273609-5677.jpg'),
(47, '/images/users/petar/portrait-white-man-isolated_53876-40306.jpg', 'portrait-white-man-isolated_53876-40306.jpg'),
(77, '/images/slide/8/fall-min.jpg', 'fall-min.jpg'),
(78, '/images/slide/2/2-2-1-4healthyeatingplanner_detailfeature.jpg', '2-2-1-4healthyeatingplanner_detailfeature.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `Message`
--

CREATE TABLE `Message` (
  `id` int(11) NOT NULL,
  `messageUsername` varchar(45) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `isRead` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Message`
--

INSERT INTO `Message` (`id`, `messageUsername`, `name`, `email`, `message`, `date`, `isRead`) VALUES
(28, 'irena', 'Irena', 'irena@gmail.com', 'Will you write blogs about the environmental protection?', '2023-11-09 00:27:41', 1),
(29, 'janko', 'Janko', 'janko@gmail', 'I want to write blogs as well, whom should I contact?', '2023-12-08 22:25:22', 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `authority` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`authority`) VALUES
('ROLE_admin'),
('ROLE_user');

-- --------------------------------------------------------

--
-- Table structure for table `Slide`
--

CREATE TABLE `Slide` (
  `id` int(11) NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `name` varchar(120) DEFAULT NULL,
  `buttonUrl` varchar(200) DEFAULT NULL,
  `buttonName` varchar(45) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Slide`
--

INSERT INTO `Slide` (`id`, `image_id`, `name`, `buttonUrl`, `buttonName`, `enabled`, `position`) VALUES
(1, 24, 'Affordable marketing ideas for your small business', 'https://www.canva.com/learn/affordable-marketing-ideas-for-your-small-business/', 'Find Out More', 1, 1),
(2, 78, '8-Week Healthy Habits Plan', 'https://www.goodhousekeeping.com/health/wellness/a42178183/8-week-healthy-habits-plan/', 'Check Out More', 1, 3),
(8, 77, 'Fall: The season of cozy, delicious, wisdom-inducing rediscovery ', 'blog-post?blogName=fall:-the-season-of-cozy,-delicious,-wisdom-inducing-rediscovery', 'Discover More', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Tag`
--

CREATE TABLE `Tag` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Tag`
--

INSERT INTO `Tag` (`id`, `name`) VALUES
(1, 'Travel'),
(5, 'Business'),
(12, 'Health'),
(13, 'Lifestyle'),
(14, 'Sports'),
(15, 'Fitness'),
(16, 'Entertainment'),
(17, 'Fashion & Trends'),
(18, 'Music'),
(19, 'Food'),
(20, 'Tips');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(45) NOT NULL,
  `password` varchar(79) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `name`, `surname`, `phoneNumber`, `email`, `enabled`, `image_id`) VALUES
('irena', '{bcrypt}$2a$12$LcgPlrqIE9bBRAOZL2OOfOum.r5/GfI0TnY04wgdNDqV7WDC8roIC', 'Irena', 'Blagojevic', '0626558521', 'irena@gmail.com', 1, 40),
('ivana', '{bcrypt}$2a$12$5rh3pvpCW0ql82ufBKY2lu8Rn/gYIdFeOh8CPFkDtUeAhSm.fIsw2', 'Ivana', 'Ivanovic', '0698761667', 'ivana@gmail.com', 0, 41),
('janko', '{bcrypt}$2a$12$OuCcugeEChH7akPSCk1fBu3mRP0I7thsVM4pzDYQo1vO3yIT2OFpS', 'Janko', 'Jankovic', '0654325536', 'janko@gmail.com', 1, 42),
('jovan', '{bcrypt}$2a$12$jV2UldUBeBuPMwEvrvO4Quj.KCP0uT0rFk.pVYH10CbIVh8KwCpYS', 'Jovan', 'Jovanovic', '0695544123', 'jovan@gmail.com', 1, 43),
('luka', '{bcrypt}$2a$12$zk8tv2eQr5WrZQUiXj9AveByFawKrWGKTNDHto7Vk3O4SBdl4rnbi', 'Luka', 'Lukic', '0658974567', 'luka@gmail.com', 1, 44),
('marija', '{bcrypt}$2a$12$qLTUpIee2QOnxJv7tG05Z.euRVo5tQgAIkSzznSUMbAxyLjNPRx6a', 'Marija', 'Maric', '0626547898', 'marija@gmail.com', 1, 45),
('marko', '{bcrypt}$2a$12$hpyYuBxuHZqsXc19QO2EV.V21pemOAUCbQn37Z4cCmIcvxft7a18W', 'Marko', 'Markovic', '0668794512', 'marko@gmail.com', 1, 46),
('petar', '{bcrypt}$2a$12$KEc/H6kqC1wtz1PoA1R0XuaCuVYbWUuZvZ0E/WW/TkGSbXpMUVb3m', 'Petar', 'Petrovic', '0658978845', 'petar@gmail.com', 0, 47);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authorities`
--
ALTER TABLE `authorities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username5_idx` (`username`),
  ADD KEY `role_idx` (`authority`);

--
-- Indexes for table `Blog`
--
ALTER TABLE `Blog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCategory_idx` (`idCategory`),
  ADD KEY `username_idx` (`userUsername`),
  ADD KEY `username_idx1` (`userUsername`),
  ADD KEY `username_idx5` (`userUsername`);

--
-- Indexes for table `Blog_Image`
--
ALTER TABLE `Blog_Image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id_idx` (`blog_id`),
  ADD KEY `image_id_idx` (`image_id`);

--
-- Indexes for table `Blog_Tag`
--
ALTER TABLE `Blog_Tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tag_idx` (`id_tag`),
  ADD KEY `id_blog_idx` (`id_blog`);

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `imageCategory_id_idx` (`image_id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idBlog_idx` (`idBlog`),
  ADD KEY `commentUsername123_idx` (`commentUsername`);

--
-- Indexes for table `Image`
--
ALTER TABLE `Image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Message`
--
ALTER TABLE `Message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messageUser_idx` (`messageUsername`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`authority`);

--
-- Indexes for table `Slide`
--
ALTER TABLE `Slide`
  ADD PRIMARY KEY (`id`),
  ADD KEY `image_id_idx` (`image_id`),
  ADD KEY `image_id787216861_idx` (`image_id`);

--
-- Indexes for table `Tag`
--
ALTER TABLE `Tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`),
  ADD KEY `imageuser_id_idx` (`image_id`),
  ADD KEY `imageUser1_id_idx` (`image_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authorities`
--
ALTER TABLE `authorities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `Blog`
--
ALTER TABLE `Blog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `Blog_Image`
--
ALTER TABLE `Blog_Image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `Blog_Tag`
--
ALTER TABLE `Blog_Tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT for table `Category`
--
ALTER TABLE `Category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `Image`
--
ALTER TABLE `Image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `Message`
--
ALTER TABLE `Message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `Slide`
--
ALTER TABLE `Slide`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `Tag`
--
ALTER TABLE `Tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authorities`
--
ALTER TABLE `authorities`
  ADD CONSTRAINT `authority` FOREIGN KEY (`authority`) REFERENCES `roles` (`authority`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Blog`
--
ALTER TABLE `Blog`
  ADD CONSTRAINT `idCategory` FOREIGN KEY (`idCategory`) REFERENCES `Category` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `userUsername` FOREIGN KEY (`userUsername`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Blog_Tag`
--
ALTER TABLE `Blog_Tag`
  ADD CONSTRAINT `id_blog` FOREIGN KEY (`id_blog`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_tag` FOREIGN KEY (`id_tag`) REFERENCES `Tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Category`
--
ALTER TABLE `Category`
  ADD CONSTRAINT `imageCategory_id` FOREIGN KEY (`image_id`) REFERENCES `Image` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `commentUser` FOREIGN KEY (`commentUsername`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idBlog` FOREIGN KEY (`idBlog`) REFERENCES `blog` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Message`
--
ALTER TABLE `Message`
  ADD CONSTRAINT `messageUser` FOREIGN KEY (`messageUsername`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Slide`
--
ALTER TABLE `Slide`
  ADD CONSTRAINT `imageSlide_id` FOREIGN KEY (`image_id`) REFERENCES `Image` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `imageUser_id` FOREIGN KEY (`image_id`) REFERENCES `Image` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
