-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 21 Şub 2026, 12:50:26
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `bb_tour_builder`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_activities`
--

CREATE TABLE `tour_activities` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_activities`
--

INSERT INTO `tour_activities` (`id`, `name`, `sort_order`, `created_at`) VALUES
(1, 'Airport Transfer', 1, '2026-02-21 11:03:37'),
(2, 'Baku City Tour', 2, '2026-02-21 11:03:37'),
(3, 'Old City Walk', 3, '2026-02-21 11:03:37');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_azerbaijan_activities_2026`
--

CREATE TABLE `tour_azerbaijan_activities_2026` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `service` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `open_time` varchar(50) DEFAULT NULL,
  `close_time` varchar(50) DEFAULT NULL,
  `duration_mins` int(11) DEFAULT NULL,
  `slots` int(11) DEFAULT NULL,
  `season` varchar(100) DEFAULT NULL,
  `adult_price` decimal(10,2) DEFAULT NULL,
  `child_price_6_12` decimal(10,2) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `city` varchar(50) NOT NULL DEFAULT 'baku'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_azerbaijan_activities_2026`
--

INSERT INTO `tour_azerbaijan_activities_2026` (`id`, `name`, `service`, `description`, `open_time`, `close_time`, `duration_mins`, `slots`, `season`, `adult_price`, `child_price_6_12`, `sort_order`, `created_at`, `city`) VALUES
(1, 'Maiden Tower', 'Entry Ticket', 'The Maiden Tower, a 12th-century UNESCO-listed landmark in Baku’s Old City (Icherisheher), is known for its unique cylindrical shape and mysterious origins. It offers panoramic views of the city and is one of Baku’s most iconic symbols, surrounded by legends about its construction and purpose.  Note:  - Not recommended for people with claustrophobia or those with knee or heart problems.  - Children must be closely supervised.  - No elevators are available, and comfortable shoes are recommended.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(2, 'Shirvanshah Palace', 'Entry Ticket', '- The Shirvanshah’s Palace, built in the 15th century, served as the royal residence of the Shirvanshah dynasty and is considered one of Azerbaijan’s finest medieval architectural masterpieces. The complex includes a mosque, mausoleum, and ceremonial courtyard that reflect the cultural peak of the Shirvan state.   NOTE: It stands as a UNESCO-listed symbol of Azerbaijan’s rich royal history.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(3, 'Miniature book museum', 'Entry Ticket', '- The museum opened on April 2, 2002. Some of the books are extremely small micro-books published in Tokyo measuring just 0.75 × 0.75 mm, or 2 × 2 mm — so tiny they can be read only with a magnifying glass. In 2015 it was officially recognized by Guinness World Records as the world’s largest private collection of miniature books.  NOTE: Mondays and Thursdays are non-operational days.', NULL, NULL, NULL, NULL, '1', 1.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(4, 'Gala Historical & Ethnographic Reserve', 'Entry Ticket', '- Established as a protected historical-ethnographic reserve in 1988, Gala Reserve offers a panoramic journey through human life on the Absheron Peninsula from ancient times to the Middle Ages. - Exhibits include archaeological monuments, reconstructed traditional houses and village life, cultural artifacts, historic structures, old ovens, workshops, and traditional crafts.', NULL, NULL, NULL, NULL, '9', 5.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(5, 'Underground Historical Hamam ', 'Entry Ticket', '- The Underground Bath is a historic hamam on Boyuk Gala Street, near the fortress gates of Icherisheher, Baku, dating back to the early 17th century.', NULL, NULL, NULL, NULL, '10', 10.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(6, 'Traditional Hamam', 'Entry Ticket: Male ', '- Traditional Hamam Experience: Includes steam and sauna, soaping and scrubbing by a male attendant, Turkish hamam rituals, hot & cold showers, towel, rubber slippers, and local tea.', NULL, NULL, NULL, NULL, '25', 25.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(7, 'Traditional Hamam', 'Entry Ticket: Female ', '- Traditional Hamam Experience: Includes steam and sauna, soaping and scrubbing by a female attendant, Turkish hamam rituals, hot & cold showers, towel, rubber slippers, and local tea.', NULL, NULL, NULL, NULL, '22', 22.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(8, 'Carpet museum', 'Entry Ticket', '- The Azerbaijan Carpet Museum, founded in 1967, houses the world’s largest collection of Azerbaijani carpets and weaving artifacts in its iconic rolled-carpet-shaped building.  NOTE: It showcases centuries-old regional carpet traditions, recognized by UNESCO as Intangible Cultural Heritage.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(9, 'Gondola ride in Mini Venice', 'Entry Ticket: 1 Lap', '- The Mini Venice Gondola Ride is a charming single-lap journey through picturesque canals, offering scenic views of bridges, architecture, and lush surroundings inspired by Venice.  Note: Each gondola accommodates a maximum of 4 people. ', NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(10, 'Ferries Wheel', 'Entry Ticket : 1 Round', '- The Ferris Wheel on Baku Boulevard is a modern landmark inspired by classic 19th–20th century wheels, offering panoramic views of the Caspian coast, historic shoreline, and modern cityscape.  Note: It has 30 cabins (4 persons each; total 120 capacity), and one full rotation takes 10–15 minutes.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(11, 'Heydar Aliyev Center Museum', 'Entry Ticket', '- The Heydar Aliyev Center, designed by Zaha Hadid and opened in 2012, is an iconic landmark of modern Azerbaijani architecture showcasing the country’s cultural and artistic heritage.  Note: The museum is closed on Mondays.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(12, 'Victory Museum ', 'Entry Ticket', '- The Victory Museum in Baku’s Victory Park commemorates Azerbaijan’s triumph in the 44-day Patriotic War, featuring a grand memorial complex.  NOTE: it includes 8 exhibition halls detailing the Karabakh conflict, major operations, the liberation of Shusha, and the restoration of sovereignty.', NULL, NULL, NULL, NULL, '9', 4.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(13, 'Vintage Car museum', 'Entry Ticket', '- The Vintage Car Museum, located inside the Heydar Aliyev Center designed by Zaha Hadid, showcases classic automobiles from the 20th century, including rare Soviet-era and European luxury cars.  Note: The museum is closed on Mondays.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(14, 'Go Karting (Outdoor - FIT)', 'Entry Ticket : Time: 10 min', '- The outdoor track at Baku Karting Center caters to groups, combining racing with social interaction and team competition. Participants can race simultaneously, compete in friendly challenges, or enjoy a shared motorsport experience. A cafeteria is available on-site for guests to relax between turns.  Note: The session lasts 10 minutes, covering 5 laps. Up to 6 people can participate in each lap at the same time. 1 hour can accommodate a group of 36 people.', NULL, NULL, NULL, NULL, '21', 21.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(15, 'Go Karting (Outdoor - GIT)', 'Entry Ticket : Time: 10 min', '- The outdoor track at Baku Karting Center caters to groups, combining racing with social interaction and team competition. Participants can race simultaneously, compete in friendly challenges, or enjoy a shared motorsport experience. A cafeteria is available on-site for guests to relax between turns.  Note: The session lasts 10 minutes, covering 5 laps. Up to 6 people can participate in each lap at the same time. 1 hour can accommodate a group of 36 people.', NULL, NULL, NULL, NULL, '21', 21.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(16, 'Go Karting (Indoor - FIT)', 'Entry Ticket : Time: 10 min', 'Indoor karting at Deniz Mall is designed for groups, letting participants race together on a professionally designed circuit. The track encourages friendly competition, teamwork, and shared excitement in a controlled, safe environment.  Note: The session lasts 10 minutes, covering 5 laps and up to 5 people can participate in each lap at the indoor track in at the same time. 1 hour can accommodate a group of 30 people.', NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(17, 'Go Karting (Indoor - GIT)', 'Entry Ticket : Time: 10 min', '- Indoor karting at Deniz Mall is designed for groups, letting participants race together on a professionally designed circuit. The track encourages friendly competition, teamwork, and shared excitement in a controlled, safe environment.  Note: The session lasts 10 minutes, covering 5 laps and up to 5 people can participate in each lap at the indoor track in at the same time. 1 hour can accommodate a group of 30 people.', NULL, NULL, NULL, NULL, '11', 11.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(18, 'Horse Riding', 'Entry Ticket : 1 ride 10 min', '- Horse riding in Baku provides a scenic and enjoyable outdoor activity suitable for individuals, families, and small groups. The activity combines the thrill of equestrian sport with the opportunity to enjoy nature and traditional horsemanship.  Note: Each ride lasts 10 minutes. Begining-level training by instuctor & helmet is included.', NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(19, 'Paintball', 'Entry Ticket : 100 Bullets', '- Paintball in Baku offers an action-packed outdoor experience with team-based strategic games on obstacle-filled fields, testing skill, teamwork, and tactics.  Note: Equipment and helmet are included, each participant gets 100 paintballs, teams of up to 8 players, supervised by trained instructors.', NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(20, 'Cruise Tour', 'Entry Ticket : 1 ride 20 min', '- Mirvari Boat Cruise along Baku Boulevard has a scenic tour of the Caspian Sea, letting visitors enjoy city skyline views, waterfront attractions, and the lively boulevard atmosphere.  Note: Can accommodate 200 people per trip, duration 20–25 minutes, and operates weather permitting.', NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(21, 'Cruise Tour VIP', 'Entry Ticket : 1 ride 20 min ', '- Mirvari Boat Cruise along Baku Boulevard has a scenic tour of the Caspian Sea, letting visitors enjoy city skyline views, waterfront attractions, and the lively boulevard atmosphere.  Note: Can accommodate 200 people per trip, duration 20–25 minutes, and operates weather permitting.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(22, 'Paintball', 'Entry Ticket : 100 Bullets', '- Paintball in Baku offers an exciting outdoor activity where participants engage in strategic, team-based games on obstacle-filled fields, testing skill, teamwork, and tactics.  Note: Equipment and helmet are provided, each participant gets 100 paintballs, teams of up to 8 players, and the activity is supervised by trained instructors for safety. ', NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(23, 'Bowling (Deniz Mall)', 'Entry Ticket : 1 hour play, including shoes', '- The facility combines casual entertainment with friendly competition, making it a popular choice for both leisure and group activities.  Note: Bowling shoes are included. Each session includes 1 hour of play.', NULL, NULL, NULL, NULL, '25', 25.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(24, 'Night Club Entry ', 'Entry Ticket : Club EXTRA', '- Extra Club in Baku is a vibrant nightlife destination where guests can enjoy music, dancing, and socializing in a modern club environment. The venue features contemporary design, lively DJ performances, and a dynamic atmosphere, making it ideal for those looking to experience Baku’s nightlife.  Note: Food & drinks are not included. Kindly take care of your belonging, as local DMC is not responsible for any lost or stolen personal items.', NULL, NULL, NULL, NULL, '1', 0.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(25, 'Night Club Entry ', 'Entry Ticket : Club FOMO', '- FOMO Club in Baku is a vibrant nightlife destination where guests can enjoy music, dancing, and socializing in a modern club environment. The venue features contemporary design, lively DJ performances, and a dynamic atmosphere, making it ideal for those looking to experience Baku’s nightlife.  Note: Food & drinks are not included. Kindly take care of your belonging, as local DMC is not responsible for any lost or stolen personal items.', NULL, NULL, NULL, NULL, '1', 0.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(26, 'Night Club Entry ', 'Entry Ticket : Club MOJO', '- MOJO Club in Baku is a vibrant nightlife destination where guests can enjoy music, dancing, and socializing in a modern club environment. The venue features contemporary design, lively DJ performances, and a dynamic atmosphere, making it ideal for those looking to experience Baku’s nightlife.  Note: Food & drinks are not included. Kindly take care of your belonging, as local DMC is not responsible for any lost or stolen personal items.', NULL, NULL, NULL, NULL, '1', 0.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(27, 'Night Club Entry ', 'Entry Ticket : Club NIGHT OFFICE', '- CLUB NIGHT OFFICE in Baku is a vibrant nightlife destination where guests can enjoy music, dancing, and socializing in a modern club environment. The venue features contemporary design, lively DJ performances, and a dynamic atmosphere, making it ideal for those looking to experience Baku’s nightlife.  Note: Food & drinks are not included. Kindly take care of your belonging, as local DMC is not responsible for any lost or stolen personal items.', NULL, NULL, NULL, NULL, '1', 0.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(28, 'Night Club Entry ', 'Entry Ticket : Club HISS', '- HISS Club in Baku is a vibrant nightlife destination where guests can enjoy music, dancing, and socializing in a modern club environment. The venue features contemporary design, lively DJ performances, and a dynamic atmosphere, making it ideal for those looking to experience Baku’s nightlife.  Note: Food & drinks are not included. Kindly take care of your belonging, as local DMC is not responsible for any lost or stolen personal items.', NULL, NULL, NULL, NULL, '1', 0.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(29, 'Night Club Entry ', 'Entry Ticket : Club HILTON 360 BAR', '- Club HILTON 360 Bar in Baku is a vibrant nightlife destination where guests can enjoy music, dancing, and socializing in a modern club environment. The venue features contemporary design, lively DJ performances, and a dynamic atmosphere, making it ideal for those looking to experience Baku’s nightlife.  Note: Food & drinks are not included. Kindly take care of your belonging, as local DMC is not responsible for any lost or stolen personal items.', NULL, NULL, NULL, NULL, '1', 0.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(30, 'Night Club Entry ', 'Entry Ticket : Club PASIFICO', '- PASIFICO Club in Baku is a vibrant nightlife destination where guests can enjoy music, dancing, and socializing in a modern club environment. The venue features contemporary design, lively DJ performances, and a dynamic atmosphere, making it ideal for those looking to experience Baku’s nightlife.  Note: Food & drinks are not included. Kindly take care of your belonging, as local DMC is not responsible for any lost or stolen personal items.', NULL, NULL, NULL, NULL, '1', 0.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(31, 'Golf', 'Entry Ticket : 9 holes', NULL, NULL, NULL, NULL, NULL, '65', 65.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(32, 'Golf', 'Entry Ticket : 18 holes', NULL, NULL, NULL, NULL, NULL, '112', 112.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(33, 'Yacht tour', 'Entry Ticket : 1 hr (6 pax), Boat Type - Mini Kater', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 6 people for a 1-hour trip. ', NULL, NULL, NULL, NULL, '30', 30.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(34, 'Yacht tour', 'Entry Ticket : 2 hr (6 pax), Boat Type - Mini Kater', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 6 people for 2-hours\' trip. ', NULL, NULL, NULL, NULL, '65', 65.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(35, 'Yacht tour', 'Entry Ticket : 3 hr (6 pax), Boat Type - Mini Kater', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 6 people for 3-hours\' trip. ', NULL, NULL, NULL, NULL, '100', 100.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(36, 'Yacht tour', 'Entry Ticket : 1 hr (8-9 pax), Boat Type: Sailing yacht', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 8 people for 1-hour trip. ', NULL, NULL, NULL, NULL, '30', 30.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(37, 'Yacht tour', 'Entry Ticket : 2 hr (8-9 pax), Boat Type: Sailing yacht', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 8 people for 2-hours\' trip. ', NULL, NULL, NULL, NULL, '65', 65.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(38, 'Yacht tour', 'Entry Ticket : 3 hr (8-9 pax), Boat Type: Sailing yacht', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 8 people for 3-hours\' trip. ', NULL, NULL, NULL, NULL, '100', 100.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(39, 'Yacht tour', 'Entry Ticket : 1 hr (10-12 pax), Boat Type: Luxury yacht', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 10 people for 1-hour trip. ', NULL, NULL, NULL, NULL, '37', 37.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(40, 'Yacht tour', 'Entry Ticket : 2 hr (10-12 pax), Boat Type: Luxury yacht', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 10 people for 2-hours\' trip. ', NULL, NULL, NULL, NULL, '80', 80.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(41, 'Yacht tour', 'Entry Ticket : 3 hr (10-12 pax), Boat Type: Luxury yacht', '- By sailing experience on the Caspian Sea guests can enjoy panoramic views of the city skyline, the Seaside Boulevard, and the surrounding coastal landscapes. The tour starts from the Seaside Boulevard, a national park, and sails all the way to the shores of Great Zira Island.  Note: Catering food & drinking alcohol is allowed. Yacht can accommodates 10 people for 3-hours\' trip. ', NULL, NULL, NULL, NULL, '125', 125.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(42, 'Fire temple, Burning Mountains', 'Combo Entry Ticket', '- The Fire Temple (Ateshgah), dating to the 17th century, stands on ancient Zoroastrian fire-worship sites, while the nearby Burning Mountains (Yanar Dag) display continuously burning natural gas flames. Yanar Dag has been officially burning since the 1950s, though natural gas fires in Absheron were known and revered since ancient times.  Note: This is an open-air complex; comfortable footwear is recommended due to rocky terrain.', NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(43, 'Mud volcano with Cars', 'With Lada Cars', '- Gobustan is home to one of the largest concentrations of mud volcanoes in the world. Around 300 of the world’s 850 mud volcanoes are located in Azerbaijan, and many of the most active ones are in the Gobustan–Absheron region. Their history goes back tens of millions of years. These iconic Old Soviet Lada off-road cars are part of the local culture and are specially designed to handle the rocky desert terrain that regular vehicles cannot reach.   Note:  - Wear sneakers - Take wet tissue - Take disposable waterproof shoe covers as the area must be sticky - Washroom is not available in Mud Volcano area ', NULL, NULL, NULL, NULL, '4', 4.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(44, 'Mud volcano with Cars', 'With 4 X 4 Cars', '- Gobustan is home to one of the largest concentrations of mud volcanoes in the world. Around 300 of the world’s 850 mud volcanoes are located in Azerbaijan, and many of the most active ones are in the Gobustan–Absheron region. Their history goes back tens of millions of years. These iconic Old Soviet Lada off-road cars are part of the local culture and are specially designed to handle the rocky desert terrain that regular vehicles cannot reach.   Note:  - Wear sneakers - Take wet tissue - Take disposable waterproof shoe covers as the area must be sticky - Washroom is not available in Mud Volcano area ', NULL, NULL, NULL, NULL, '8', 8.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(45, 'Mud Volcanoes Complex - Museum ', 'Entry Ticket', '- Gobustan is home to one of the largest concentrations of mud volcanoes in the world. Around 300 of the world’s 850 mud volcanoes are located in Azerbaijan, and many of the most active ones are in the Gobustan–Absheron region. Their history goes back tens of millions of years. The Mud Volcano Tourism Complex near Baku is a curated area where visitors can safely explore multiple small mud volcanoes, formed by eruptions of mud, water, and gas from beneath the earth.  Note:  - Washroom is available  - The complex offers guided visits, educational insights, scenic walking paths, and photography opportunities.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(46, 'Gobustan Rocks Arts Museums', 'Entry Ticket', '- The Gobustan Rock Art Museum preserves and exhibits ancient petroglyphs and carvings that date back over 5,000 years, showcasing the region’s prehistoric culture and lifestyle. The museum provides historical context to the rock engravings, highlighting hunting scenes, ritual symbols, and daily life of early human settlements. You can explore both indoor exhibitions and the open-air archaeological site, making it a comprehensive cultural and historical experience. You should not forget to take picture with the ledge of rock in the shape of a lion’s head.  Note:  - The museum is best visited with comfortable footwear as the site includes outdoor walking paths. - Washroom is available. ', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(47, 'Shooting Center Baku', 'Riffle shooting (Per Person - 5 bullets) ', '- Riffle shooting experience of flying objects or non-moving objects. Participants can practice their aim under the supervision of trained instructors, using professional equipment and following strict safety protocols.   Note:  - Safety earplugs are included. - Guests with back/spine/chest pain are not allowed to participate.  - Each participant is allowed 5 bullets per session under instructor control. ', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(48, 'Shooting Center Baku', 'Riffle shooting (Per Person - 10 bullets) ', '- Riffle shooting experience of flying objects or non-moving objects. Participants can practice their aim under the supervision of trained instructors, using professional equipment and following strict safety protocols.   Note:  - Safety earplugs are included. - Guests with back/spine/chest pain are not allowed to participate.  - Each participant is allowed 10 bullets per session under instructor control. ', NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(49, 'Azerbaijan E-Visa', 'E-Visa - Normal', '- Azerbaijan E-Visa (Standard Tourist): Valid for short stays up to 30 days within a 90-day validity.  Note:  - Requires a passport soft copy. - Processing takes 3-5 working days. - Passport must be valid 3–6 months beyond the stay.', NULL, NULL, NULL, NULL, '31', 31.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(50, 'Azerbaijan E-Visa', 'E-Visa - Urgent', '- Azerbaijan Urgent E-Visa (Standard Tourist): Valid for short stays up to 30 days within a 90-day validity.  Note:  - Requires a passport soft copy. - Processing takes 3-5 working hours. - Passport must be valid 3–6 months beyond the stay.', NULL, NULL, NULL, NULL, '65', 65.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(51, 'Daily Water', '2 Bottles per day', NULL, NULL, NULL, NULL, NULL, '2', 2.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(52, 'Beer Package - Group Supplement ', 'Beer Package (1 x 500 ML Local beer PP - Bottle/Can)', NULL, NULL, NULL, NULL, NULL, '2', 2.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(53, 'Alcohol Package (2 hrs free flow) - Group Supplement ', 'Alcohol served (Local Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(54, 'Alcohol Package (2 hrs free flow) - Group Supplement ', 'Alcohol served (Local Wiskey, Local Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '7', 7.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(55, 'Alcohol Package (2 hrs free flow) - Group Supplement ', 'Alcohol served (Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '2', 2.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(56, 'Alcohol Package (2 hrs free flow) - Group Supplement ', 'Alcohol served (Wiskey - Black Label, Local Vodka, Local Beer)', NULL, NULL, NULL, NULL, NULL, '10', 10.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(57, 'Alcohol Package (2 hrs free flow) - Group Supplement ', 'Alcohol Package - (Wiskey - Black Label, Absolute Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(58, 'Alcohol Package (2 hrs free flow) - Group Supplement ', 'Alcohol served (Only Beer)', NULL, NULL, NULL, NULL, NULL, '2', 2.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(59, 'Alcohol Package (2 hrs free flow) - Group Supplement ', 'Alcohol Package - (Wiskey - Black Label, Absolute, Bacardi, Local Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '14', 14.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(60, 'Corkage Fee - Group Supplement', 'Corkage fee Per Bottle at Restaurant', NULL, NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(61, 'Corkage Fee - Group Supplement', 'Corkage fee Per Bottle at Hotel', NULL, NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(62, 'Alcohol Package (3 hrs free flow)  - Group Supplement', 'Alcohol served (Local Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '5', 5.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(63, 'Alcohol Package (3 hrs free flow)  - Group Supplement', 'Alcohol served (Local Wiskey, Local Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(64, 'Alcohol Package (3 hrs free flow)  - Group Supplement', 'Alcohol served (Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '4', 4.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(65, 'Alcohol Package (3 hrs free flow)  - Group Supplement', 'Alcohol served (Wiskey - Black Label, Local Vodka, Local Beer)', NULL, NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(66, 'Alcohol Package (3 hrs free flow)  - Group Supplement', 'Alcohol Package - (Wiskey - Black Label, Absolute Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '14', 14.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(67, 'Alcohol Package (3 hrs free flow)  - Group Supplement', 'Alcohol served (Only Beer)', NULL, NULL, NULL, NULL, NULL, '4', 4.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(68, 'Alcohol Package (3 hrs free flow)  - Group Supplement', 'Alcohol Package - (Wiskey - Black Label, Absolute, Bacardi, Local Vodka, Local Beer, Local Wine)', NULL, NULL, NULL, NULL, NULL, '16', 16.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(69, 'Starters - Group Supplement', '1 V Starter', NULL, NULL, NULL, NULL, NULL, '1.5', 1.50, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(70, 'Starters - Group Supplement', '2 V Starter', NULL, NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(71, 'Starters - Group Supplement', '1 NV Starter', NULL, NULL, NULL, NULL, NULL, '1.5', 1.50, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(72, 'Starters - Group Supplement', '2 NV Starter', NULL, NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(73, 'Starters - Group Supplement', '1V + 1NV Starter', NULL, NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(74, 'Starters - Group Supplement', '2V + 1NV Starter', NULL, NULL, NULL, NULL, NULL, '4', 4.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(75, 'Starters - Group Supplement', '2V + 2NV Starter', NULL, NULL, NULL, NULL, NULL, '5', 5.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(76, 'Entertainment - Group Supplement', 'DJ (without Sound System)- 3 Hours', NULL, NULL, NULL, NULL, NULL, '60', 60.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(77, 'Entertainment - Group Supplement', 'DJ (with Sound System)- 3 Hours', NULL, NULL, NULL, NULL, NULL, '89', 89.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(78, 'Entertainment - Group Supplement', 'Local Traditional Dancer (1Boy +1Girl - 1 performance x 10 mins)', NULL, NULL, NULL, NULL, NULL, '60', 60.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(79, 'Entertainment - Group Supplement', 'Local Traditional Dancer (2Boy +2Girl - 1 performance x 10 mins)', NULL, NULL, NULL, NULL, NULL, '119', 119.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(80, 'Entertainment - Group Supplement', 'Local Traditional Dancer (4Boy +4Girl - 1 performance x 10 mins)', NULL, NULL, NULL, NULL, NULL, '266', 266.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(81, 'Entertainment - Group Supplement', 'Belly Dancer - 1 Dancer (20 Mins)', NULL, NULL, NULL, NULL, NULL, '30', 30.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(82, 'Entertainment - Group Supplement', 'Belly Dancer - 2 Dancer (20 Mins)', NULL, NULL, NULL, NULL, NULL, '60', 60.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(83, 'Entertainment - Group Supplement', 'Belly Dancer - 3 Dancer (20 Mins)', NULL, NULL, NULL, NULL, NULL, '90', 90.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(84, 'Entertainment - Group Supplement', 'Belly Dancer - 4 Dancer (20 Mins)', NULL, NULL, NULL, NULL, NULL, '120', 120.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(85, 'Entertainment - Group Supplement', 'Bollywood Dancers - 4 Girls (1 performance x 10 mins)', NULL, NULL, NULL, NULL, NULL, '208', 208.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(86, 'Funicular Ride at Highland Park', 'Entry Ticket: 1 Way', '- Either up to Highland Park or down to the city center, giving passengers breathtaking views of Baku and the Caspian Sea along the way. The funicular was first constructed in the 1960s as part of Baku’s urban development, making it both a practical transport link and a tourist attraction. The ride takes you past the lush greenery of the park and provides access to landmarks like Martyrs’ Alley, the Eternal Flame, and panoramic viewpoints over the city.', NULL, NULL, NULL, NULL, '1', 1.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(87, 'Funicular Ride at Highland Park', 'Entry Ticket: 2 Way', '- The round-trip ticket allows visitors to travel both up and down Highland Park, providing a complete scenic experience. This historic funicular has become an iconic symbol of Baku, blending mid-20th-century engineering with stunning views of the Caspian coastline. Along the journey, passengers can admire the city’s skyline, waterfront, and the park’s landscaped gardens, making it a popular choice for both locals and tourists.', NULL, NULL, NULL, NULL, '2', 2.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(88, 'Caspian Cruise', 'Entry Ticket: Standard Seat - 20 Mins', '- Caspian Cruise trip offers a scenic journey along Baku’s coastline, providing views of the city’s blend of historic architecture and modern skyline. Passengers can see landmarks such as the Baku Boulevard, the Flame Towers, and historic port areas, all while enjoying the fresh sea breeze. The cruise celebrates Baku’s long-standing connection to the Caspian Sea, which has been central to the city’s trade, culture, and maritime history for centuries.  Note: This activity operates subject to weather conditions.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(89, 'Caspian Cruise', 'Entry Ticket: VIP Seat - 20 Mins', '- VIP Caspian cruise seat provides an elevated experience with premium seating, ensuring unobstructed panoramic views of Baku’s waterfront and cityscape. In addition to the sights of Baku Boulevard and the Flame Towers, the VIP option allows visitors to fully relax while enjoying the historical context of Baku as a key Caspian port. The Caspian Cruise offers a combination of sightseeing, leisure, and appreciation of the city’s maritime heritage in a more luxurious setting.  Note: This activity operates subject to weather conditions.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(90, 'Event', 'Stage (56 Mtr)', NULL, NULL, NULL, NULL, NULL, '592', 592.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(91, 'Event', 'Rollup (1 Pcs)', NULL, NULL, NULL, NULL, NULL, '50', 50.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(92, 'Event', 'Rollup (4 Pcs)', NULL, NULL, NULL, NULL, NULL, '150', 150.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(93, 'Event', 'Backdrop (1 Pc)', NULL, NULL, NULL, NULL, NULL, '89', 89.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(94, 'Event', 'Lights (8 Pcs)', NULL, NULL, NULL, NULL, NULL, '190', 190.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(95, 'Event', 'Truss (13 Mtr)', NULL, NULL, NULL, NULL, NULL, '77', 77.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(96, 'Event', 'LED Monitor (36 Mtr)', NULL, NULL, NULL, NULL, NULL, '1243', 1243.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(97, 'Event', 'Sound System ', NULL, NULL, NULL, NULL, NULL, '237', 237.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(98, 'Baliqli Lake Picnic Package', 'All Inclusive - Minimum 4 Pax', 'Included: - Transportation - Entrance - Coal - Fuel - Tea & Barbecue Equipment - Indoor & Outdoor Sitting Area - Max. for 4 / 6 / 8/ 10 person.   Note: Food and drinks rates are not included, this will be depend on guest choice.', NULL, NULL, NULL, NULL, '14', 14.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(99, 'Aquapark', 'Entry Ticket', 'Guests can enjoy the following facilities and attractions:  - Locker - Towel - Restrooms - Changing rooms - Lifeguard assistance - Tube slides - Main swimming pool access - Water playground zone for kids  Note: Food and beverages are not included and are available at an additional cost.', NULL, NULL, NULL, NULL, '30', 30.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(100, 'Swimming Pool', 'Entry Ticket', 'Included:  - Locker - Towel - Restrooms - Changing rooms - Lifeguard assistance - Main swimming pool access - Pool for kids  Note: Food and beverages are not included and are available at an additional cost.', NULL, NULL, NULL, NULL, '20', 20.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(101, 'Kids\' Activities', 'Slide Baku (Denizmall)', '- Experience the famous multi-level glass slide inside Deniz Mall, offering a fun and exciting ride with stunning indoor views.', NULL, NULL, NULL, NULL, '5', 5.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(102, 'Kids\' Activities', 'Softplay Area (Denizmall)', '- A safe and colorful play zone for young children, filled with soft structures, worry-free fun for 1 hour. ', NULL, NULL, NULL, NULL, '20', 20.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(103, 'Kids\' Activities', 'Skypark Rooftop (Denizmall)', '- Sky Park is one of the main entertainment zones inside Deniz Mall — located on the 5th floor. It’s designed as a fun and modern amusement area, offering a variety of attractions for both kids and adults. The concept promises excitement — “lifting your feet off the ground and raising you to the tops,” hinting at dynamic, high energy entertainment. For families: a safe, indoor entertainment zone where kids and adults can enjoy together.', NULL, NULL, NULL, NULL, '25', 25.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(104, 'Kids\' Activities', 'VR Glasses (Denizmall)', '- Strap on the VR headset and feel the excitement of a high-speed car race — a fully immersive virtual reality experience!', NULL, NULL, NULL, NULL, '22', 22.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(105, 'Kids\' Activities', 'Train Excursion (Baku Boulevard)', '- Children can hop aboard a charming mini-train and enjoy a scenic excursion along the famous Baku Boulevard, taking in the sights of the Caspian Sea and the city’s waterfront.', NULL, NULL, NULL, NULL, '5', 5.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(106, 'Kids\' Activities', 'Scary Home (Baku Boulevard)', '- Scary Home is a horror-themed attraction designed to give visitors a thrilling and spooky experience. Guests walk through dark, themed rooms filled with sound effects, special lighting, and surprise scares, making it a fun stop for those who enjoy adrenaline-filled activities along Baku Boulevard.', NULL, NULL, NULL, NULL, '14', 14.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(107, 'Kids\' Activities', 'Bumper Cars ride (Baku Boulevard)', '- The Bumper Cars ride is a lively and entertaining attraction where guests can drive small electric cars around a dedicated arena and gently bump into one another in a safe and controlled environment. With upbeat music and colorful lights, it creates a cheerful atmosphere that appeals to both children and adults. It’s a great activity for families and friends to enjoy some light-hearted fun while taking a break during their walk along Baku Boulevard.', NULL, NULL, NULL, NULL, '1', 1.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(108, 'Kids\' Activities', 'Ice Rink', '- The Ice Rink offers a refreshing and enjoyable experience where visitors can skate on a well-maintained ice surface, regardless of the season. It is suitable for both beginners and experienced skaters, with skate rentals available on site. The cool atmosphere, music, and lively setting make it a fun activity for families, couples, and friends looking to enjoy something active and different.', NULL, NULL, NULL, NULL, '1', 1.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(109, 'Kids\' Activities', 'Color Lab Art Space', '- Color Lab Art Space is an interactive and creative attraction where visitors can explore rooms filled with vibrant colors, lights, and artistic installations. It offers a fun, immersive experience that encourages creativity and is perfect for taking unique photos and videos. This space is especially popular with art lovers and anyone looking for a modern, visually engaging activity.', NULL, NULL, NULL, NULL, '1', 1.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(110, 'Fire temple - Ateshgah', 'Entry Ticket', '- The Fire Temple (Ateshgah) near Baku, built in the 17th century on ancient Zoroastrian fire-worship sites, features a pentagonal structure with a central altar, monk cells, and inscriptions.  Note: This is an open-air complex; comfortable footwear is recommended due to rocky terrain.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(111, 'Burning Mountains - Yanardag', 'Entry Ticket', '- Burning Mountains (Yanar Dag) display continuously burning natural gas flames. Yanar Dag has been officially burning since the 1950s, though natural gas fires in Absheron were known and revered since ancient times.  Note: This is an open-air complex; comfortable footwear is recommended due to rocky terrain.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(112, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(113, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(114, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(115, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(116, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(117, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(118, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(119, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(120, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(121, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(122, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(123, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(124, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(125, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(126, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(127, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(128, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(129, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(130, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(131, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(132, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(133, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(134, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(135, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(136, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(137, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(138, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(139, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(140, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(141, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(142, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(143, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(144, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(145, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(146, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(147, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(148, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(149, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(150, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(151, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(152, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(153, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(154, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(155, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(156, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(157, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(158, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(159, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(160, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(161, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(162, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(163, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(164, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(165, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(166, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(167, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(168, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(169, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(170, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(171, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(172, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(173, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(174, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(175, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(176, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(177, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(178, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(179, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(180, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(181, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(182, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(183, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(184, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(185, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(186, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(187, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(188, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(189, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(190, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(191, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(192, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(193, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(194, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(195, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(196, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(197, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(198, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(199, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(200, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(201, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(202, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(203, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(204, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(205, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(206, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(207, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(208, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(209, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(210, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(211, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku');
INSERT INTO `tour_azerbaijan_activities_2026` (`id`, `name`, `service`, `description`, `open_time`, `close_time`, `duration_mins`, `slots`, `season`, `adult_price`, `child_price_6_12`, `sort_order`, `created_at`, `city`) VALUES
(212, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(213, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(214, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(215, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(216, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(217, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(218, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(219, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(220, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(221, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(222, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(223, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(224, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(225, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(226, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(227, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(228, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(229, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(230, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(231, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(232, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(233, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(234, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(235, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(236, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(237, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(238, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(239, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(240, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(241, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(242, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(243, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(244, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(245, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(246, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(247, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(248, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(249, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(250, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(251, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(252, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(253, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(254, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(255, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(256, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(257, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(258, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(259, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(260, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(261, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(262, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(263, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(264, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(265, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(266, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(267, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(268, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(269, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(270, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(271, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(272, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(273, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(274, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(275, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(276, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(277, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(278, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(279, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(280, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(281, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(282, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(283, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(284, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(285, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(286, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(287, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(288, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(289, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(290, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(291, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(292, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(293, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(294, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(295, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(296, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(297, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(298, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(299, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(300, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(301, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(302, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(303, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(304, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(305, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(306, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(307, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(308, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(309, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(310, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(311, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(312, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(313, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(314, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(315, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(316, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(317, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(318, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(319, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(320, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(321, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(322, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(323, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(324, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(325, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(326, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(327, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(328, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(329, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(330, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(331, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(332, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(333, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(334, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(335, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(336, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(337, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(338, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(339, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(340, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(341, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(342, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(343, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(344, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(345, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(346, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(347, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(348, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(349, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(350, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(351, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(352, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(353, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(354, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(355, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(356, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(357, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(358, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(359, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(360, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(361, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(362, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(363, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(364, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(365, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(366, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(367, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(368, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(369, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(370, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(371, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(372, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(373, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(374, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(375, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(376, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(377, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(378, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(379, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(380, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(381, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(382, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(383, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(384, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(385, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(386, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(387, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(388, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(389, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(390, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(391, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(392, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(393, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(394, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(395, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(396, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(397, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(398, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(399, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(400, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(401, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(402, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(403, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(404, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(405, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(406, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(407, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(408, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(409, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(410, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(411, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(412, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(413, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(414, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(415, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(416, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(417, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(418, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(419, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(420, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(421, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(422, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(423, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(424, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(425, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(426, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(427, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(428, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(429, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(430, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(431, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(432, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(433, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(434, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(435, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(436, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(437, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(438, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(439, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(440, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(441, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(442, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(443, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(444, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(445, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(446, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(447, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(448, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(449, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(450, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(451, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(452, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(453, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(454, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(455, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(456, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(457, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(458, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(459, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(460, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(461, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(462, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(463, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(464, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(465, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(466, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(467, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(468, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(469, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(470, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(471, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(472, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(473, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(474, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(475, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(476, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(477, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(478, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(479, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(480, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(481, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(482, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(483, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(484, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(485, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(486, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(487, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(488, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(489, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(490, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(491, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(492, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(493, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(494, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(495, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(496, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(497, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(498, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(499, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(500, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(501, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(502, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(503, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(504, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(505, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(506, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(507, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(508, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(509, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(510, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(511, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(512, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(513, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(514, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(515, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(516, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(517, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(518, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(519, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(520, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(521, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(522, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(523, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(524, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(525, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(526, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(527, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(528, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(529, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(530, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(531, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(532, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(533, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(534, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(535, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(536, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(537, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(538, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(539, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(540, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(541, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(542, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(543, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(544, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(545, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(546, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(547, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(548, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(549, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(550, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(551, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(552, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(553, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(554, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(555, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(556, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(557, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(558, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(559, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(560, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(561, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(562, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(563, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(564, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(565, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(566, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(567, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(568, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(569, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(570, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(571, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(572, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(573, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(574, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(575, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(576, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(577, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(578, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(579, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(580, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(581, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(582, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(583, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(584, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(585, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(586, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(587, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(588, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(589, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(590, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(591, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(592, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(593, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(594, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(595, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(596, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(597, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(598, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(599, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(600, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(601, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(602, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(603, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(604, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(605, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(606, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(607, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(608, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(609, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(610, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(611, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(612, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(613, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(614, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(615, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(616, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(617, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(618, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(619, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(620, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(621, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(622, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(623, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(624, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(625, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(626, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(627, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(628, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(629, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(630, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(631, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(632, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(633, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(634, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(635, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(636, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(637, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(638, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(639, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(640, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(641, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(642, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(643, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(644, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(645, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(646, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(647, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(648, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(649, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(650, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(651, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(652, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(653, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(654, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(655, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(656, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(657, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(658, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(659, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(660, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(661, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(662, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(663, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(664, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(665, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(666, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(667, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(668, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(669, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(670, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(671, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(672, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(673, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(674, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(675, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(676, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(677, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(678, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(679, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(680, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(681, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(682, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(683, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(684, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(685, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(686, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(687, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(688, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(689, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(690, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(691, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(692, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(693, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(694, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(695, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(696, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(697, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(698, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(699, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(700, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(701, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(702, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(703, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(704, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(705, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(706, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(707, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(708, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(709, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(710, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(711, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(712, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(713, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(714, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(715, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(716, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(717, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(718, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(719, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(720, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(721, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(722, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(723, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(724, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(725, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(726, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(727, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(728, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(729, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(730, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(731, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(732, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(733, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(734, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku');
INSERT INTO `tour_azerbaijan_activities_2026` (`id`, `name`, `service`, `description`, `open_time`, `close_time`, `duration_mins`, `slots`, `season`, `adult_price`, `child_price_6_12`, `sort_order`, `created_at`, `city`) VALUES
(735, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(736, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(737, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(738, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(739, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(740, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(741, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(742, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(743, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(744, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(745, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(746, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(747, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(748, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(749, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(750, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(751, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(752, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(753, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(754, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(755, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(756, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(757, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(758, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(759, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(760, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(761, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(762, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(763, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(764, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(765, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(766, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(767, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(768, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(769, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(770, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(771, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(772, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(773, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(774, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(775, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(776, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(777, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(778, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(779, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(780, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(781, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(782, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(783, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(784, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(785, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(786, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(787, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(788, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(789, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(790, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(791, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(792, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(793, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(794, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(795, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(796, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(797, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(798, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(799, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(800, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(801, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(802, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(803, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(804, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(805, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(806, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(807, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(808, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(809, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(810, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(811, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(812, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(813, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(814, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(815, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(816, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(817, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(818, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(819, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(820, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(821, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(822, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(823, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(824, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(825, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(826, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(827, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(828, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(829, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(830, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(831, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(832, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(833, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(834, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(835, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(836, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(837, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(838, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(839, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(840, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(841, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(842, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(843, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(844, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(845, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(846, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(847, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(848, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(849, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(850, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(851, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(852, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(853, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(854, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(855, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(856, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(857, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(858, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(859, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(860, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(861, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(862, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(863, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(864, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(865, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(866, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(867, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(868, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(869, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(870, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(871, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(872, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(873, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(874, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(875, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(876, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(877, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(878, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(879, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(880, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(881, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(882, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(883, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(884, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(885, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(886, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(887, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(888, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(889, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(890, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(891, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(892, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(893, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(894, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(895, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(896, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(897, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(898, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(899, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(900, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(901, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(902, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(903, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(904, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(905, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(906, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(907, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(908, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(909, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(910, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(911, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(912, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(913, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(914, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(915, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(916, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(917, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(918, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(919, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(920, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(921, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(922, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(923, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(924, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(925, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(926, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(927, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(928, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(929, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(930, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(931, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(932, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(933, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(934, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(935, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(936, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(937, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(938, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(939, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(940, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(941, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(942, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(943, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(944, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(945, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(946, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(947, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(948, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(949, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(950, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(951, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(952, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(953, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(954, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(955, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(956, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(957, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(958, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(959, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(960, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(961, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(962, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(963, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(964, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(965, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(966, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(967, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(968, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(969, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(970, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(971, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(972, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(973, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(974, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(975, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(976, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(977, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(978, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(979, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(980, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(981, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(982, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(983, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(984, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(985, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(986, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(987, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(988, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(989, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(990, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(991, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(992, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(993, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(994, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(995, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(996, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(997, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(998, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(999, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1000, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1001, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1002, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1003, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1004, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1005, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1006, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1007, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1008, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1009, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1010, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1011, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1012, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1013, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1014, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1015, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1016, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1017, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1018, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1019, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1020, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1021, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1022, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1023, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1024, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1025, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1026, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1027, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1028, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1029, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1030, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1031, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1032, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1033, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1034, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1035, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1036, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1037, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1038, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1039, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1040, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1041, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1042, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1043, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1044, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1045, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1046, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1047, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1048, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1049, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1050, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1051, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1052, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1053, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1054, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1055, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1056, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1057, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1058, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1059, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1060, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1061, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1062, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1063, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1064, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1065, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1066, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1067, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1068, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1069, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1070, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1071, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1072, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1073, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1074, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1075, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1076, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1077, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1078, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1079, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1080, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1081, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1082, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1083, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1084, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1085, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1086, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1087, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1088, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1089, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1090, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1091, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1092, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1093, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1094, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1095, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1096, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1097, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1098, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1099, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1100, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1101, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1102, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1103, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1104, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1105, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1106, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1107, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1108, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1109, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1110, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1111, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1112, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1113, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1114, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1115, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1116, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1117, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1118, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1119, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1120, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1121, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1122, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1123, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1124, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1125, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1126, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1127, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1128, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1129, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1130, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1131, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1132, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1133, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1134, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1135, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1136, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1137, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1138, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1139, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1140, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1141, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1142, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1143, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1144, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1145, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1146, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1147, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1148, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1149, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1150, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1151, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1152, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1153, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1154, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1155, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1156, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1157, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1158, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1159, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'baku'),
(1160, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1161, 'Meysari Wine Tour (Min 6 Pax)', 'Entry Ticket ', '- The Meysari Wine Tour offers a guided visit to one of Azerbaijan’s most renowned wineries, where guests can learn about local winemaking traditions and modern production techniques. The tour includes a walk through the vineyards and winery facilities, followed by a tasting of selected wines. A minimum of 6 participants is required to operate this tour, making it ideal for groups interested in experiencing Azerbaijani wine culture and local flavors together.', NULL, NULL, NULL, NULL, '20', 20.00, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1162, 'Savalan Wine Tour (Min 6 Pax)', 'Entry Ticket ', '- The Savalan Wine Tour provides a guided visit to a premium winery set against scenic mountain landscapes, offering insight into Azerbaijan’s modern winemaking process. Guests explore the vineyards and production areas before enjoying a tasting of selected Savalan wines. A minimum of 6 participants is required for this tour, making it a perfect choice for groups seeking a relaxed and cultural wine experience', NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1163, 'Alpaca Village ', 'Entry Ticket ', '- Alpaca Village is a unique and family-friendly attraction where visitors can see, interact with, and take photos with gentle alpacas in a natural countryside setting. Guests can learn about these animals, feed them, and enjoy a calm, relaxing atmosphere away from the city. It is an ideal experience for families, animal lovers, and anyone looking for a peaceful and memorable activity.', NULL, NULL, NULL, NULL, '21', 21.00, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1164, 'Shamakhy Astrophysical Observatory named after Nasiruddin Tusi ', 'Entry Ticket', '- This observatory is one of the leading scientific centers in the region, dedicated to astronomical research and education. Visitors can learn about stars, planets, and space through guided explanations, telescopes, and exhibitions, while also discovering the legacy of the famous scientist Nasiruddin Tusi. The visit offers an educational and inspiring experience, combining science, history, and panoramic mountain views.', NULL, NULL, NULL, NULL, '8', 8.00, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1165, 'Samaxi Cuxuryurd Package', 'All Inclusive - Minimum 4 Pax', '- The Samaxi Cuxuryurd Package offers a relaxing and immersive countryside experience in the picturesque region of Samaxi. Guests can enjoy guided tours of local vineyards, gardens, and cultural sites, participate in traditional activities, and savor authentic Azerbaijani cuisine. This package is ideal for those seeking a blend of nature, culture, and leisure, providing a memorable escape from the city.', NULL, NULL, NULL, NULL, '10', 10.00, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1166, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1167, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1168, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1169, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1170, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1171, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1172, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1173, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1174, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1175, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1176, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1177, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1178, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1179, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1180, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1181, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1182, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1183, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1184, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1185, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1186, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1187, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1188, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1189, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1190, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1191, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1192, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1193, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1194, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1195, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1196, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1197, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1198, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1199, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1200, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1201, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1202, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1203, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1204, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1205, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1206, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1207, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1208, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1209, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1210, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1211, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1212, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1213, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1214, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1215, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1216, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1217, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1218, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1219, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1220, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1221, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1222, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1223, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shamakhi'),
(1224, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala');
INSERT INTO `tour_azerbaijan_activities_2026` (`id`, `name`, `service`, `description`, `open_time`, `close_time`, `duration_mins`, `slots`, `season`, `adult_price`, `child_price_6_12`, `sort_order`, `created_at`, `city`) VALUES
(1225, 'Gabala Cable Car', 'Entry Ticket : 2 lines', '- The 2-lines Gabala Cable Car (1 line up + 1 line down) offers a scenic ride over lush forests and mountainous terrain, with each cabin accommodating up to 3 people. Visitors can enjoy stunning panoramic views of the Gabala region in a peaceful and intimate setting, making it perfect for families or small groups to capture memorable photos.', NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1226, 'Gabala Cable Car', 'Entry Ticket : 4 lines', '- The 4-lines Gabala Cable Car (2 lines up + 2 lines down) provides a longer and more adventurous experience, with each cabin holding up to 3 people. Guests can explore multiple sections of the mountains, enjoying breathtaking landscapes and varied perspectives, making it ideal for small groups or families seeking an immersive nature experience.', NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1227, 'Quad bike tours', 'Entry Ticket : 1 pax ', '- The single-rider quad bike tour offers an exhilarating 4 km off-road adventure lasting approximately 15 minutes. Designed for guests over 18 years old, it allows participants to navigate rugged terrains, enjoy the thrill of speed, and take in the surrounding natural landscapes. This activity is ideal for adventure enthusiasts looking for a short but action-packed experience.', NULL, NULL, NULL, NULL, '27', 27.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1228, 'Quad bike tours', 'Entry Ticket : 2 pax', '- The 2-person quad bike tour allows two guests to ride together on a single vehicle for a 4 km journey lasting around 15 minutes. Suitable for riders over 18 years old, it combines excitement and teamwork, letting participants share the thrill of navigating off-road trails while enjoying the scenic views. This option is perfect for friends or couples seeking a fun and adventurous activity in nature.', NULL, NULL, NULL, NULL, '36', 36.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1229, 'Quad bike tours for kids', 'Entry Ticket : Age 8-14 years old', '- The kids’ quad bike tour offers a safe and fun 10-minute ride designed for children aged 8 to 14 years old. The course is adapted to be gentle and easy to navigate, allowing young riders to enjoy the excitement of driving a quad bike in a controlled environment. This activity is perfect for kids who want a taste of adventure while staying safe under supervision.', NULL, NULL, NULL, NULL, '-', 0.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1230, 'Rafting', 'Entry Ticket : Depends on level of river', '- The rafting experience offers an adventurous way to navigate rivers, with the intensity and duration of the activity depending on the river’s level and conditions. Guided by experienced instructors, participants can enjoy the thrill of rapids while staying safe. It’s suitable for groups seeking an adrenaline-filled outdoor activity and can be tailored to different skill levels, from beginners to more experienced rafters.  Note: Available only in summer season (June/July/August). ', NULL, NULL, NULL, NULL, '21', 21.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1231, 'Shooting ', 'Entry Ticket : 25 Bullets', '- Riffle shooting experience of flying objects or non-moving objects. Participants can practice their aim under the supervision of trained instructors, using professional equipment and following strict safety protocols.   Note:  - Safety earplugs are included. - Guests with back/spine/chest pain are not allowed to participate.  - Each participant is allowed 10 bullets per session under instructor control.', NULL, NULL, NULL, NULL, '30', 30.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1232, 'Nohur Lake boat riding', 'Entry Ticket: 4 Pax in 1 boat', '- The Nohur Lake boat riding experience allows up to 4 guests to enjoy a serene and scenic ride on the calm waters of Nohur Lake. Visitors can take in the surrounding natural beauty, relax on the water, and capture memorable photos. It’s an ideal activity for families or small groups looking for a peaceful and leisurely outdoor experience.', NULL, NULL, NULL, NULL, '4', 4.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1233, 'Nohur Lake horse riding', 'Entry Ticket : 1 Pax ', '- The Nohur Lake horse riding experience allows a single guest to explore the scenic landscapes surrounding the lake on horseback. Suitable for all skill levels, riders can enjoy a peaceful journey through nature while taking in the beautiful views. This activity is perfect for those seeking a relaxing outdoor adventure combined with the charm of horseback riding.', NULL, NULL, NULL, NULL, '10', 10.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1234, 'Gabaland Amusement park', 'Entry Ticket ', '- The Gabaland Amusement park offers a variety of rides and entertainment options suitable for families, children, and thrill-seekers. Visitors should be prepared to wait in queues for popular attractions, but the diverse range of rides and activities ensures a fun and memorable experience for everyone.', NULL, NULL, NULL, NULL, '18', 18.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1235, 'Gabaland Go Karting', 'Entry Ticket ', '- The Gabaland Karting experience offers a thrilling 5-minute ride on a professionally designed track. Guests can test their driving skills and enjoy the excitement of speed in a safe and controlled environment. It’s a fun activity for both adults and older children seeking an adrenaline-filled experience within the amusement park.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1236, 'Computer games', 'Entry Ticket : 1 Game', '- This activity allows guests to enjoy one session of computer or arcade gaming. It offers a fun and interactive way to test skills, compete with friends, or simply relax and enjoy digital entertainment. Ideal for both kids and adults, it provides a short but engaging break within a larger entertainment or amusement setting.', NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1237, 'Tir shooting ', 'Entry Ticket : 5 Shots', '- The Tir shooting activity allows participants to fire 5 shots at designated targets in a safe and controlled environment. Guided by trained instructors, guests can practice their aim, focus on precision, and enjoy the thrill of shooting. It’s a fun and engaging activity suitable for those seeking a brief but exciting experience.', NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1238, 'Electrical boat', 'Entry Ticket : 10 mins', '- The electric boat ride offers a peaceful 10-minute journey on calm waters, allowing guests to enjoy the surrounding scenery and relax while gliding across the water. It’s suitable for individuals, couples, or small groups looking for a calm and scenic experience, providing a perfect break from more active attractions.', NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1239, 'Electrical motocycle', 'Entry Ticket : 10 mins', '- The electric motorcycle ride provides a thrilling 10-minute experience where guests can enjoy riding a small, motorized bike in a safe and controlled environment. It’s designed for both beginners and those looking for a fun, adrenaline-filled activity, making it an exciting option for kids, teens, and adults seeking a short but memorable adventure.', NULL, NULL, NULL, NULL, '3', 3.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1240, 'Gabala Cable Car (2 Lines), Alpine Coaster', 'Combo Entry ticket', '- This combo ticket allows guests to enjoy both the scenic Gabala Cable Car ride and the thrilling coaster experience in one visit. Each cable car cabin accommodates up to 3 people, and the ride spans a height of 2 km, offering breathtaking panoramic views of the lush mountains and forests. After the cable car, guests can experience the adrenaline rush of the coaster, with exciting twists and turns. This combination is perfect for those seeking both stunning scenery and adventure in Gabala.', NULL, NULL, NULL, NULL, '41', 41.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1241, 'Gabala Coaster ', 'Entry Ticket ', '- The Alpine Coaster in Gabala is a thrilling mountain ride where visitors glide along a winding track through scenic landscapes, combining adventure with panoramic views of the surrounding forests and hills.  Note: The coaster is suitable for both adults and children; riders must follow safety instructions and height/weight requirements. ', NULL, NULL, NULL, NULL, '30', 30.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1242, 'Lavender Garden', 'Entry Ticket ', 'The Lavender Garden in Gabala is a scenic attraction featuring vast fields of blooming lavender, offering visitors a peaceful and fragrant environment ideal for walking, photography, and relaxation.  Note:  - Best visited during the lavender flowering season (May/June/July). - Photo-op areas: additional 3 azn per spot for specific photo locations (swings, stairs, etc.)', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1243, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1244, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1245, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1246, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1247, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1248, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1249, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1250, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1251, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1252, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1253, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1254, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1255, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1256, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1257, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1258, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1259, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1260, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1261, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1262, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1263, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1264, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1265, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1266, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1267, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1268, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1269, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1270, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1271, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1272, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1273, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1274, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1275, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1276, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1277, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1278, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1279, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1280, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1281, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1282, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1283, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1284, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1285, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1286, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1287, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1288, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1289, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'gabala'),
(1290, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1291, 'Shahdag Coaster', 'Entry Ticket : 1 pax', '- The Alpine Coaster in Shahdag is a thrilling mountain ride where visitors glide along a winding track through scenic landscapes, combining adventure with panoramic views of the surrounding forests and hills.  Note: The coaster is suitable for both adults and children; riders must follow safety instructions and height/weight requirements.', NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1292, 'Shahdag Coaster', 'Entry Ticket : 2 pax extra in one coaster', '- The Alpine Coaster in Shahdag is a thrilling mountain ride where visitors glide along a winding track through scenic landscapes, combining adventure with panoramic views of the surrounding forests and hills.  Note: The coaster is suitable for both adults and children; riders must follow safety instructions and height/weight requirements.', NULL, NULL, NULL, NULL, '14', 14.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1293, 'Shahdag Cable Car', 'Entry Ticket: 1 Line', '- The 2-lines Shahdag Cable Car (1 line up + 1 line down) offers a scenic ride over lush forests and mountainous terrain, with each cabin accommodating up to 3 people. Visitors can enjoy stunning panoramic views of the Gabala region in a peaceful and intimate setting, making it perfect for families or small groups to capture memorable photos.', NULL, NULL, NULL, NULL, '11', 11.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1294, 'Segway', 'Entry Ticket : 10 min', '- The 10-minute Segway ride offers a fun and easy way for guests to explore the area while gliding effortlessly on a self-balancing electric vehicle. It’s suitable for beginners and provides a short but enjoyable experience, allowing participants to get a feel for riding a Segway while enjoying the surroundings.', NULL, NULL, NULL, NULL, '10', 10.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1295, 'Segway', 'Entry Ticket : 20 min', '- The 20-minute Segway ride gives guests a longer opportunity to explore and enjoy the area at a relaxed pace. Ideal for both beginners and those more comfortable with the Segway, this extended ride', NULL, NULL, NULL, NULL, '15', 15.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1296, 'Segway', 'Entry Ticket : 30 min', '- The 30-minute Segway ride provides an extended and immersive experience, allowing guests to explore the area more thoroughly while gliding smoothly on a self-balancing electric vehicle. Suitable for beginners and experienced riders alike, this longer ride gives ample time to enjoy the scenery, take photos, and fully experience the fun and convenience of riding a Segway.', NULL, NULL, NULL, NULL, '18', 18.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1297, 'Paintball', 'Entry Ticket : 200 balls (over 14 years old)', '- This paintball activity allows participants over 14 years old to enjoy an action-packed session with 200 paintballs. Fully equipped with protective gear, players can engage in strategic games, aim at targets, and enjoy a competitive and adrenaline-filled experience. Ideal for groups seeking extended fun and excitement.', NULL, NULL, NULL, NULL, '24', 24.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1298, 'Paintball', 'Entry Ticket : 100 balls (over 14 years old)', '- The 100-ball paintball option provides a shorter but still thrilling session for participants over 14 years old. With full safety gear provided, players can enjoy team-based or individual challenges, making it a fun and engaging activity for friends or family.', NULL, NULL, NULL, NULL, '16', 16.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1299, 'Paintball', 'Entry Ticket : 50 balls (over 14 years old)', '- The 50-ball paintball option is perfect for a quick, exciting introduction to the game for participants over 14 years old. With protective equipment included, this session offers a brief but fun experience, ideal for those who want to try paintball without committing to a longer game.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1300, 'Quad tours', 'Entry Ticket : 10 min 1 pax', '- This 10-minute quad tour for a single rider offers an exciting off-road adventure, allowing guests to navigate short trails and enjoy the thrill of speed. Suitable for those over 18, it’s a fun way to experience the outdoors in a safe and controlled environment.', NULL, NULL, NULL, NULL, '16', 16.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1301, 'Quad tours', 'Entry Ticket : 10 min 2 pax', '- The 10-minute quad tour for two guests allows riders to share the excitement on a single vehicle. Participants can enjoy a fun and safe off-road adventure together, making it perfect for friends or couples seeking a short but thrilling experience', NULL, NULL, NULL, NULL, '12', 12.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1302, 'Quad tours', 'Entry Ticket : 20 min 1 pax', '- The 20-minute single-rider quad tour provides a longer and more immersive off-road adventure. Guests can explore scenic trails, experience varying terrains, and enjoy an extended adrenaline-filled ride while remaining safely in control of the quad bike.', NULL, NULL, NULL, NULL, '30', 30.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1303, 'Quad tours', 'Entry Ticket : 20 min 2 pax', '- The 20-minute two-person quad tour offers an extended adventure for two guests on a single vehicle. Riders can share the thrill of navigating off-road trails, enjoy scenic views, and have a memorable experience together over a longer duration.', NULL, NULL, NULL, NULL, '25', 25.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1304, 'Buggy tours', 'Entry Ticket : 10 min 1 pax', '- This 10-minute buggy tour for a single rider provides a thrilling off-road experience, allowing guests to navigate dirt tracks and scenic trails while enjoying the excitement of driving a powerful buggy. It’s ideal for adventure seekers looking for a short, adrenaline-filled ride.', NULL, NULL, NULL, NULL, '23', 23.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1305, 'Buggy tours', 'Entry Ticket : 10 min 2 pax', '- The 10-minute two-person buggy tour allows two guests to ride together on a single vehicle. Sharing the ride adds fun and excitement, making it perfect for friends or couples who want to experience a brief but exhilarating off-road adventure together.', NULL, NULL, NULL, NULL, '23', 23.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1306, 'Buggy tours', 'Entry Ticket : 20 min 1 pax', '- The 20-minute single-rider buggy tour offers a longer and more immersive off-road adventure. Guests can explore varied terrains, enjoy the thrill of driving over challenging tracks, and take in the surrounding scenery for a more extended and exciting experience.', NULL, NULL, NULL, NULL, '25', 25.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1307, 'Buggy tours', 'Entry Ticket : 20 min 2 pax', '- The 20-minute two-person buggy tour provides an extended adventure for two guests sharing one vehicle. Riders can enjoy navigating trails together, experiencing the thrill of speed, and appreciating the natural landscapes over a longer and more immersive ride.', NULL, NULL, NULL, NULL, '25', 25.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1308, 'Bobkart', 'Entry Ticket : 1 descent', '- The Bobkart experience offers a single thrilling descent down a winding, specially designed track. Guests can feel the adrenaline as they navigate twists, turns, and gentle slopes while enjoying a fun and safe ride. It’s perfect for first-time riders or anyone seeking a short but exciting adventure.', NULL, NULL, NULL, NULL, '10', 10.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1309, 'Bobkart', 'Entry Ticket : 2 descent', '- The two-descent option allows guests to double their excitement, riding the track twice and mastering its twists and turns. With each run, participants can enjoy the speed and thrill more confidently while taking in the surrounding scenery. This option is ideal for those who want a longer, more engaging Bobkart experience.', NULL, NULL, NULL, NULL, '16', 16.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1310, 'Bobkart', 'Entry Ticket : 3 descent', '- The three-descent option provides a full Bobkart adventure, allowing riders to experience the track three times. Guests can enjoy the thrill of high-speed turns, experiment with different racing lines, and fully immerse themselves in the fun and excitement of the ride. It’s perfect for thrill-seekers looking to maximize their experience and create lasting memories.', NULL, NULL, NULL, NULL, '18', 18.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1311, 'Horse back riding', 'Entry Ticket : 10 min (over 3 years old )', '- This 10-minute horseback riding experience allows guests aged 3 and above to enjoy a gentle ride through scenic trails or open spaces. Riders can experience the joy of being on horseback, connect with the animals, and take in the natural surroundings. It’s a family-friendly activity suitable for beginners and children, providing a safe, relaxing, and memorable outdoor adventure.', NULL, NULL, NULL, NULL, '10', 10.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1312, 'Polaris Tour', 'Entry Ticket : 10 min', '- The 10-minute Polaris tour offers a short but thrilling ride in an off-road Polaris vehicle. Guests can navigate trails, experience mild bumps and turns, and enjoy the excitement of an adventure through scenic landscapes. It’s perfect for first-time riders or those looking for a quick adrenaline-filled experience.', NULL, NULL, NULL, NULL, '23', 23.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1313, 'Polaris Tour', 'Entry Ticket : 20 min', '- The 20-minute Polaris tour provides a longer and more immersive off-road adventure. Riders can explore more trails, enjoy varied terrains, and take in the natural scenery while experiencing the full excitement of driving a Polaris vehicle. This option is ideal for adventure enthusiasts who want a more extended and engaging experience.', NULL, NULL, NULL, NULL, '36', 36.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1314, 'Archery', 'Entry Ticket : 8 shoots', '- This archery activity allows participants to take 8 shots at designated targets in a safe and controlled environment. Guided by trained instructors, guests can practice their aim, improve focus and precision, and enjoy the satisfying challenge of hitting the target. It’s a fun and engaging activity suitable for beginners and those looking to test their skills in a safe, outdoor setting', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1315, 'Catapult', 'Entry Ticket ', '- This archery activity allows participants to take 8 shots at designated targets in a safe and controlled environment. Guided by trained instructors, guests can practice their aim, improve focus and precision, and enjoy the satisfying challenge of hitting the target. It’s a fun and engaging activity suitable for beginners and those looking to test their skills in a safe, outdoor setting', NULL, NULL, NULL, NULL, '25', 25.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1316, 'Swing', 'Entry Ticket ', '- The swing activity allows one guest to enjoy a high, scenic swing in a safe and controlled setting. Riders can feel the excitement of soaring through the air while taking in the surrounding views, making it a fun and exhilarating experience for both children and adults.', NULL, NULL, NULL, NULL, '18', 18.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1317, 'Trampoline', 'Entry Ticket : 10 min', '- The swing activity allows one guest to enjoy a high, scenic swing in a safe and controlled setting. Riders can feel the excitement of soaring through the air while taking in the surrounding views, making it a fun and exhilarating experience for both children and adults.', NULL, NULL, NULL, NULL, '4', 4.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1318, 'Trampoline', 'Entry Ticket : 20 min', '- The 20-minute trampoline session provides an extended opportunity to enjoy jumping, bouncing, and practicing tricks. Guests can burn off more energy, improve balance and coordination, and have a longer, fun-filled experience suitable for all ages.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1319, 'Catamaran', 'Entry Ticket ', '- The catamaran activity allows a single guest to enjoy a relaxing ride on calm waters. Guests can paddle at their own pace, take in the scenic surroundings, and enjoy a peaceful and leisurely experience on the lake. It’s perfect for those seeking a calm and refreshing outdoor activity', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1320, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1321, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1322, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1323, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1324, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1325, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1326, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1327, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1328, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1329, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1330, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1331, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1332, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1333, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1334, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1335, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1336, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1337, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1338, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1339, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1340, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1341, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1342, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1343, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1344, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1345, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1346, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1347, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1348, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1349, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1350, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1351, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1352, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1353, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1354, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1355, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1356, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1357, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1358, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1359, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1360, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1361, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1362, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1363, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1364, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1365, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1366, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1367, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1368, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1369, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1370, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1371, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1372, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1373, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1374, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1375, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1376, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1377, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1378, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1379, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1380, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1381, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1382, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1383, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1384, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1385, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1386, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1387, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1388, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1389, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1390, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1391, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1392, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1393, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'shahdag'),
(1394, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1395, 'Shaki Khans\' Palace ', ' Entry Ticket', '- Shaki Khans’ Palace is a historic architectural gem featuring intricate stained-glass windows, frescoes, and traditional Azerbaijani design. Visitors can explore the palace halls, learn about the history of the Shaki khans, and admire the rich cultural heritage of the region', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1396, 'Kish Church', ' Entry Ticket', '- Kish Church is an ancient Albanian temple with historical and religious significance. Guests can explore its stone architecture, learn about early Christian history in the region, and enjoy the peaceful surroundings.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1397, 'Biogarden', ' Entry Ticket', '- Biogarden is an eco-friendly attraction offering visitors a chance to explore local flora, gardens, and sustainable farming practices. It provides a relaxing and educational experience, perfect for nature lovers and families.', NULL, NULL, NULL, NULL, '6', 6.00, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1398, 'Catapult', 'Entry Ticket', '- Catapult is an adventurous outdoor activity where participants can engage in a safe and thrilling catapult-style ride or experience. It’s ideal for adrenaline seekers looking for a short but exciting adventure in a natural setting.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1399, 'Zipline', 'Entry Ticket ', '-The Zipline in Shahdag is an adventure attraction that lets visitors glide over the scenic mountains and forests of the Shahdag Mountain Resort, offering thrilling rides with panoramic views.  Note: Riders must follow safety instructions, meet height and weight requirements, and wear the provided harness and helmet.', NULL, NULL, NULL, NULL, '9', 9.00, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1400, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1401, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1402, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1403, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1404, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1405, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1406, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1407, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1408, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1409, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1410, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1411, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1412, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1413, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1414, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1415, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1416, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1417, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1418, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1419, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1420, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1421, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1422, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1423, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1424, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1425, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1426, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1427, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1428, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1429, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1430, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1431, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1432, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1433, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1434, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1435, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1436, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1437, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1438, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1439, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1440, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1441, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1442, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1443, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1444, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1445, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1446, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1447, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1448, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1449, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1450, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1451, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1452, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki'),
(1453, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 09:04:52', 'sheki');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_countries`
--

CREATE TABLE `tour_countries` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_countries`
--

INSERT INTO `tour_countries` (`id`, `name`, `sort_order`, `created_at`) VALUES
(1, 'India', 1, '2026-02-21 11:03:36'),
(2, 'Pakistan', 2, '2026-02-21 11:03:36'),
(3, 'United Arab Emirates', 3, '2026-02-21 11:03:36'),
(4, 'Saudi Arabia', 4, '2026-02-21 11:03:36'),
(5, 'United Kingdom', 5, '2026-02-21 11:03:36');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_entrances`
--

CREATE TABLE `tour_entrances` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_entrances`
--

INSERT INTO `tour_entrances` (`id`, `name`, `sort_order`, `created_at`) VALUES
(1, 'No Entrance Needed', 1, '2026-02-21 11:03:37'),
(2, 'Flame Towers', 2, '2026-02-21 11:03:37'),
(3, 'Maiden Tower', 3, '2026-02-21 11:03:37');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_guides`
--

CREATE TABLE `tour_guides` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_guides`
--

INSERT INTO `tour_guides` (`id`, `name`, `sort_order`, `created_at`) VALUES
(1, 'English Speaking Guide', 1, '2026-02-21 11:03:37'),
(2, 'Arabic Speaking Guide', 2, '2026-02-21 11:03:37'),
(3, 'Russian Speaking Guide', 3, '2026-02-21 11:03:37'),
(4, 'English Speaking Driver only', 4, '2026-02-21 11:03:37');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_hotels`
--

CREATE TABLE `tour_hotels` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `region` varchar(50) NOT NULL DEFAULT 'baku',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_hotels`
--

INSERT INTO `tour_hotels` (`id`, `name`, `region`, `sort_order`, `created_at`) VALUES
(1, 'JW Marriott Baku', 'baku', 1, '2026-02-21 11:03:37'),
(2, 'Hilton Baku', 'baku', 2, '2026-02-21 11:03:37'),
(3, 'Four Seasons', 'baku', 3, '2026-02-21 11:03:37'),
(4, 'Holiday Inn Baku', 'baku', 4, '2026-02-21 11:03:37');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_hotel_prices`
--

CREATE TABLE `tour_hotel_prices` (
  `id` int(11) UNSIGNED NOT NULL,
  `hotel_name` varchar(120) NOT NULL,
  `region` varchar(50) NOT NULL DEFAULT 'baku',
  `room_type` varchar(120) NOT NULL DEFAULT '',
  `season_type` varchar(50) NOT NULL DEFAULT 'peak',
  `price` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_hotel_prices`
--

INSERT INTO `tour_hotel_prices` (`id`, `hotel_name`, `region`, `room_type`, `season_type`, `price`, `created_at`) VALUES
(1, 'Wyndham Baku', 'baku', 'Double Room (2P)', 'peak', 85.00, '2026-02-21 10:13:47'),
(2, '7 Gozel', 'gabala', 'Double Room (2P)', 'peak', 76.00, '2026-02-21 10:13:47'),
(3, 'Alis Hotel', 'baku', 'Double Room (2P)', 'peak', 33.00, '2026-02-21 10:13:47'),
(4, 'Cosy Hotel', 'baku', 'Double Room (2P)', 'peak', 60.00, '2026-02-21 10:13:47'),
(5, 'Boutique', 'baku', 'Double Room (2P)', 'peak', 60.00, '2026-02-21 10:13:47'),
(6, 'Callisto', 'baku', 'Double Room (2P)', 'peak', 68.00, '2026-02-21 10:13:47'),
(7, 'Promonade', 'baku', 'Superior Double (2P)', 'peak', 144.00, '2026-02-21 10:13:47'),
(8, 'Ibis Hotel', 'baku', 'Double Room (2P)', 'peak', 85.00, '2026-02-21 10:13:47'),
(9, 'Ibis Hotel', 'baku', 'Single Room (0EB) (1P)', 'peak', 71.00, '2026-02-21 10:13:47'),
(10, 'Ibis Hotel', 'baku', 'Twin Room (2P)', 'peak', 85.00, '2026-02-21 10:13:47'),
(11, 'Ibis Hotel', 'baku', 'Family Room  (3P)', 'peak', 117.00, '2026-02-21 10:13:47'),
(12, 'Ibis Hotel', 'baku', 'Premium Room ( Single )', 'peak', 83.00, '2026-02-21 10:13:47'),
(13, 'Ibis Hotel', 'baku', 'Premium Room ( D/T)', 'peak', 96.00, '2026-02-21 10:13:47'),
(14, 'Ibis Hotel', 'baku', 'Extra Bed (Adult)', 'peak', 35.00, '2026-02-21 10:13:47'),
(15, 'Ibis Hotel', 'baku', 'Extra Bed (Child)', 'peak', 28.00, '2026-02-21 10:13:47'),
(16, 'Ibis Hotel', 'baku', 'Child without Bed (CNB)', 'peak', 1.00, '2026-02-21 10:13:47'),
(17, 'Grand Amar', 'baku', 'Double Room (2P)', 'peak', 44.00, '2026-02-21 10:13:47'),
(18, 'Gabala karvansaray', 'gabala', 'Double Room (2P)', 'peak', 115.00, '2026-02-21 10:13:47'),
(19, 'Metro City', 'baku', 'Double Room (2P)', 'peak', 41.00, '2026-02-21 10:13:47'),
(20, 'Radisson Baku', 'baku', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(21, 'Monte Napoleone', 'baku', 'Double Room (2P)', 'peak', 88.00, '2026-02-21 10:13:47'),
(22, 'Ivy Garden', 'baku', 'Double Room (2P)', 'peak', 82.00, '2026-02-21 10:13:47'),
(23, 'Iris', 'baku', 'Double Room (2P)', 'peak', 71.00, '2026-02-21 10:13:47'),
(24, 'Wyndham Garden', 'baku', 'Double Room (2P)', 'peak', 86.00, '2026-02-21 10:13:47'),
(25, 'Badamdar Estates', 'baku', 'Double Room (2P)', 'peak', 92.00, '2026-02-21 10:13:47'),
(26, 'Sahil', 'baku', 'Double Room (2P)', 'peak', 85.00, '2026-02-21 10:13:47'),
(27, 'Sapphire Inn', 'baku', 'Double Room (2P)', 'peak', 95.00, '2026-02-21 10:13:47'),
(28, 'Sapphire Bayil', 'baku', 'Double Room (2P)', 'peak', 89.00, '2026-02-21 10:13:47'),
(29, 'Sapphire Marine', 'baku', 'Double Room (2P)', 'peak', 106.00, '2026-02-21 10:13:47'),
(30, 'City Park Hotel', 'baku', 'Double Room (2P)', 'peak', 77.00, '2026-02-21 10:13:47'),
(31, 'Sapphire City', 'baku', 'Double Room (2P)', 'peak', 136.00, '2026-02-21 10:13:47'),
(32, 'Grandmidway', 'baku', 'Double Room (2P)', 'peak', 77.00, '2026-02-21 10:13:47'),
(33, 'Liman Hotel', 'baku', 'Double Room (2P)', 'peak', 38.00, '2026-02-21 10:13:47'),
(34, 'Nohur Hotel', 'baku', 'Double Room (2P)', 'peak', 88.00, '2026-02-21 10:13:47'),
(35, 'Austin', 'baku', 'Double Room (2P)', 'peak', 60.00, '2026-02-21 10:13:47'),
(36, 'Grand Ammar', 'baku', 'Double Room (2P)', 'peak', 45.00, '2026-02-21 10:13:47'),
(37, 'The Atrum', 'baku', 'Double Room (2P) No window', 'peak', 101.00, '2026-02-21 10:13:47'),
(38, 'Midtown', 'baku', 'Double Room (2P)', 'peak', 95.00, '2026-02-21 10:13:47'),
(39, 'Graaf hotel', 'baku', 'Double Room (2P)', 'peak', 55.00, '2026-02-21 10:13:47'),
(40, 'Volga', 'baku', 'Double Room (2P)', 'peak', 47.00, '2026-02-21 10:13:47'),
(41, 'Adisson', 'baku', 'Double Room (2P)', 'peak', 48.00, '2026-02-21 10:13:47'),
(42, 'Alba Hotel', 'baku', 'Double Room (2P)', 'peak', 50.00, '2026-02-21 10:13:47'),
(43, 'Boulevard Marriott', 'baku', 'Double Room City View (2P)', 'peak', 135.00, '2026-02-21 10:13:47'),
(44, 'Qafqaz City', 'baku', 'Double Room Type A (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(45, 'Diamond Hotel', 'baku', 'Double Room (2P)', 'peak', 54.00, '2026-02-21 10:13:47'),
(46, 'Yengice Hotel - Gabala', 'gabala', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(47, 'Atlas', 'baku', 'Double Room (2P)', 'peak', 75.00, '2026-02-21 10:13:47'),
(48, 'Pik Palace Hotel - Shahdag', 'shahdag', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(49, 'LakeSide Hotel - Gabala', 'gabala', 'Double Room (2P)', 'peak', 47.00, '2026-02-21 10:13:47'),
(50, 'Ilk Inn Hotel - Shahdag', 'shahdag', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(51, 'Zirve Hotel - Shahdag', 'shahdag', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(52, 'Tufandag Mountain Resort - Gabala', 'baku', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(53, 'Qafqaz Riverside - Gabala', 'gabala', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(54, 'Gabala Garden - Gabala', 'gabala', 'Double Room (2P)', 'peak', 1.00, '2026-02-21 10:13:47'),
(55, 'Ramada by Whyndham', 'baku', 'Standard Single City View Room (1P)', 'peak', 95.00, '2026-02-21 10:13:47'),
(56, 'Hillpark Hotel', 'baku', 'Deluxe Single', 'peak', 1.00, '2026-02-21 10:13:47'),
(57, 'Badam D art', 'baku', 'Double Room (2P)', 'peak', 85.00, '2026-02-21 10:13:47');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_meal_options`
--

CREATE TABLE `tour_meal_options` (
  `id` int(11) UNSIGNED NOT NULL,
  `city` varchar(50) NOT NULL DEFAULT 'baku',
  `meal_type` enum('breakfast','lunch','dinner') NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_meal_options`
--

INSERT INTO `tour_meal_options` (`id`, `city`, `meal_type`, `name`, `sort_order`, `created_at`) VALUES
(1, 'baku', 'breakfast', 'Hotel Buffet Breakfast', 1, '2026-02-21 11:03:37'),
(2, 'baku', 'breakfast', 'Set Menu Breakfast', 2, '2026-02-21 11:03:37'),
(3, 'baku', 'breakfast', 'No Breakfast', 3, '2026-02-21 11:03:37'),
(4, 'baku', 'lunch', 'Local Restaurant Lunch', 1, '2026-02-21 11:03:37'),
(5, 'baku', 'lunch', 'Hotel Lunch', 2, '2026-02-21 11:03:37'),
(6, 'baku', 'lunch', 'Lunch Box', 3, '2026-02-21 11:03:37'),
(7, 'baku', 'dinner', 'Local Restaurant Dinner', 1, '2026-02-21 11:03:37'),
(8, 'baku', 'dinner', 'Hotel Dinner', 2, '2026-02-21 11:03:37'),
(9, 'baku', 'dinner', 'Dinner Cruise', 3, '2026-02-21 11:03:37');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_transfer_point_a`
--

CREATE TABLE `tour_transfer_point_a` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `region` varchar(50) NOT NULL DEFAULT 'baku',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_transfer_point_b`
--

CREATE TABLE `tour_transfer_point_b` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `region` varchar(50) NOT NULL DEFAULT 'baku',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_transfer_services`
--

CREATE TABLE `tour_transfer_services` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `region` varchar(50) NOT NULL DEFAULT 'baku',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_vehicles`
--

CREATE TABLE `tour_vehicles` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_vehicles`
--

INSERT INTO `tour_vehicles` (`id`, `name`, `sort_order`, `created_at`) VALUES
(1, 'Sedan (Up to 3 pax)', 1, '2026-02-21 11:03:37'),
(2, 'Vito (Up to 6 pax)', 2, '2026-02-21 11:03:37'),
(3, 'Sprinter (Up to 15 pax)', 3, '2026-02-21 11:03:37');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_visa_types`
--

CREATE TABLE `tour_visa_types` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_visa_types`
--

INSERT INTO `tour_visa_types` (`id`, `name`, `sort_order`, `created_at`) VALUES
(1, 'Not Required', 1, '2026-02-21 11:03:37'),
(2, 'Standard (3-5 Days)', 2, '2026-02-21 11:03:37'),
(3, 'Urgent (3 Hours)', 3, '2026-02-21 11:03:37');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tour_water_packages`
--

CREATE TABLE `tour_water_packages` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `tour_water_packages`
--

INSERT INTO `tour_water_packages` (`id`, `name`, `sort_order`, `created_at`) VALUES
(1, '1x 300ml daily', 1, '2026-02-21 11:03:37'),
(2, '2x 300ml daily', 2, '2026-02-21 11:03:37'),
(3, 'None', 3, '2026-02-21 11:03:37');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `tour_activities`
--
ALTER TABLE `tour_activities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Tablo için indeksler `tour_azerbaijan_activities_2026`
--
ALTER TABLE `tour_azerbaijan_activities_2026`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_name_service` (`name`,`service`);

--
-- Tablo için indeksler `tour_countries`
--
ALTER TABLE `tour_countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Tablo için indeksler `tour_entrances`
--
ALTER TABLE `tour_entrances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Tablo için indeksler `tour_guides`
--
ALTER TABLE `tour_guides`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Tablo için indeksler `tour_hotels`
--
ALTER TABLE `tour_hotels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `region_name` (`region`,`name`(100)),
  ADD KEY `region` (`region`);

--
-- Tablo için indeksler `tour_hotel_prices`
--
ALTER TABLE `tour_hotel_prices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hotel_room_season` (`hotel_name`(80),`region`,`room_type`(80),`season_type`),
  ADD KEY `region` (`region`);

--
-- Tablo için indeksler `tour_meal_options`
--
ALTER TABLE `tour_meal_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `city_meal_type_name` (`city`,`meal_type`,`name`),
  ADD KEY `city` (`city`);

--
-- Tablo için indeksler `tour_transfer_point_a`
--
ALTER TABLE `tour_transfer_point_a`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `region_name` (`region`,`name`(150)),
  ADD KEY `region` (`region`);

--
-- Tablo için indeksler `tour_transfer_point_b`
--
ALTER TABLE `tour_transfer_point_b`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `region_name` (`region`,`name`(150)),
  ADD KEY `region` (`region`);

--
-- Tablo için indeksler `tour_transfer_services`
--
ALTER TABLE `tour_transfer_services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `region_name` (`region`,`name`(150)),
  ADD KEY `region` (`region`);

--
-- Tablo için indeksler `tour_vehicles`
--
ALTER TABLE `tour_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Tablo için indeksler `tour_visa_types`
--
ALTER TABLE `tour_visa_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Tablo için indeksler `tour_water_packages`
--
ALTER TABLE `tour_water_packages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `tour_activities`
--
ALTER TABLE `tour_activities`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `tour_azerbaijan_activities_2026`
--
ALTER TABLE `tour_azerbaijan_activities_2026`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1454;

--
-- Tablo için AUTO_INCREMENT değeri `tour_countries`
--
ALTER TABLE `tour_countries`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `tour_entrances`
--
ALTER TABLE `tour_entrances`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `tour_guides`
--
ALTER TABLE `tour_guides`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `tour_hotels`
--
ALTER TABLE `tour_hotels`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `tour_hotel_prices`
--
ALTER TABLE `tour_hotel_prices`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- Tablo için AUTO_INCREMENT değeri `tour_meal_options`
--
ALTER TABLE `tour_meal_options`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `tour_transfer_point_a`
--
ALTER TABLE `tour_transfer_point_a`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `tour_transfer_point_b`
--
ALTER TABLE `tour_transfer_point_b`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `tour_transfer_services`
--
ALTER TABLE `tour_transfer_services`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `tour_vehicles`
--
ALTER TABLE `tour_vehicles`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `tour_visa_types`
--
ALTER TABLE `tour_visa_types`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `tour_water_packages`
--
ALTER TABLE `tour_water_packages`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
