-- Movie data base 

create table directors (
	id int generated always as identity primary key,
	director_name varchar(50) not null unique check (char_length(director_name) >= 3),
	notes text
);

insert into directors (director_name, notes) 
values
('Christopher Nolan', 'Known for non-linear storytelling'),
('Quentin Tarantino', 'Famous for stylized violence'),
('Greta Gerwig', 'Focuses on female-driven narratives'),
('Hayao Miyazaki', 'Master of animated fantasy'),
('Denis Villeneuve', 'Sci-fi and psychological thrillers');


create table genres (
	id int generated always as identity primary key,
	genre_name varchar(50) not null unique check (char_length(genre_name) >= 3),
	notes text
);

insert into genres (genre_name, notes) 
values
('Drama', 'Emotional and character-driven'),
('Comedy', 'Light-hearted and humorous'),
('Sci-Fi', 'Futuristic and speculative'),
('Fantasy', 'Magical and mythical worlds'),
('Thriller', 'Suspense and tension');


create table categories (
	id int generated always as identity primary key,
	category_name varchar(50) not null unique check (char_length(category_name) >= 3),
	notes text
);

insert into categories (category_name, notes) 
values
('Feature Film', 'Full-length movies'),
('Short Film', 'Under 40 minutes'),
('Documentary', 'Non-fiction storytelling'),
('Animation', 'Animated content'),
('Experimental', 'Non-traditional formats');

create table movies (
	id int generated always as identity primary key,
	title varchar(50) not null unique check (char_length(title) >= 3),
	director_id int not null references directors(id),
	copyright_year int check (copyright_year > 1900),
	length interval not null,
	genre_id int not null references genres(id),
	category_id int not null references categories(id),
	rating numeric(3,1) check (rating between 0 and 10),
	notes text 
);
insert into movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
values
('Inception', 1, 2010, interval '2 hours 28 minutes', 3, 1, 8.8, 'Mind-bending thriller'),
('Pulp Fiction', 2, 1994, interval '2 hours 34 minutes', 5, 1, 8.9, 'Non-linear crime story'),
('Lady Bird', 3, 2017, interval '1 hour 34 minutes', 1, 1, 7.4, 'Coming-of-age drama'),
('Spirited Away', 4, 2001, interval '2 hours 5 minutes', 4, 4, 8.6, 'Animated fantasy adventure'),
('Arrival', 5, 2016, interval '1 hour 56 minutes', 3, 1, 8.0, 'Linguistic sci-fi mystery');



select * from movies;
