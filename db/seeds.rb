# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Trip.create(id: '1', name: 'Japan', created_at: '2014-11-16 02:49:55 UTC', updated_at: '2014-11-18 11:07:55 UTC', start_date: '2014-01-01 00:00:00 UTC', end_date: '2014-01-10 00:00:00 UTC', banner_image: 'http://www.lemon-holidays.com/images/banner-home-japan.jpg')
Trip.create(id: '2', name: 'airport', created_at: '2014-11-17 08:09:19 UTC', updated_at: '2014-11-18 11:10:37 UTC', start_date: '2015-09-28 00:00:00 UTC', end_date: '2015-09-28 00:00:00 UTC', banner_image: 'http://slovenia-excursion.com/wp-content/uploads/2014/02/bannerairport2.jpg')

Area.create(id: '1', trip_id: '1', name: 'area', description: 'such area description', image: 'https://d2z6c3c3r6k4bx.cloudfront.net/uploads/event/banner/1002189/rc-header.png', link: 'https://ti.to/ruby-australia/rails-camp-perth-2014', created_at: '2014-11-16 02:51:30 UTC', updated_at: '2014-11-19 07:29:52 UTC', proposed_date: '2014-01-09 00:00:00 UTC')
Area.create(id: '2', trip_id: '1', name: 'another area', description: 'some other descrtiptuion', image: 'asdfjkldf', link: 'slkcdjfl', created_at: '2014-11-16 03:05:01 UTC', updated_at: '2014-11-19 07:07:18 UTC', proposed_date: '2013-12-31 00:00:00 UTC')
Area.create(id: '3', trip_id: '1', name: 'some other area', description: 'adfsojkdsf', image: 'aodifj', link: 'assdfopikjsdfg', created_at: '2014-11-16 03:05:55 UTC', updated_at: '2014-11-18 09:26:43 UTC', proposed_date: '2014-01-06 00:00:00 UTC')
Area.create(id: '4', trip_id: '2', name: 'carpark', description: 'such car', image: 'lkdjflksdjf', link: 'skldnflskdnfj', created_at: '2014-11-17 08:10:04 UTC', updated_at: '2014-11-17 10:41:09 UTC', proposed_date: '2015-08-31 00:00:00 UTC')
Area.create(id: '5', trip_id: '2', name: 'tarmac', description: 'planes biatch', image: 's;kdgj', link: 's;ldkgj', created_at: '2014-11-17 08:11:07 UTC', updated_at: '2014-11-17 10:41:11 UTC', proposed_date: '2015-09-07 00:00:00 UTC')

Attraction.create(id: '1', area_id: '1', name: 'attraction name', description: 'such attractive description', cost: Money.new(12_20), image: 'http://www.expattaxjapan.com/japan-garden_00245728.jpg', link: 'http://maps.google.com/maps?q=Woodman+Point+Recreation+Camp', created_at: '2014-11-16 02:54:35 UTC', updated_at: '2014-11-18 12:17:52 UTC')
Attraction.create(id: '2', area_id: '1', name: 'attraction name', description: 'such attractive description', cost: Money.new(12_20), image: 'https://maps.googleapis.com/maps/api/staticmap?size=640x366&maptype=roadmap&center=-32.132731%2C115.75512900000001&markers=size:mid%7Ccolor:blue&sensor=false&format=png32&scale=2&visual_refresh=true&zoom=14&key=AIzaSyC9qsX58pj60d-Ga_06b40fl3YGRnxArD4', link: 'http://maps.google.com/maps?q=Woodman+Point+Recreation+Camp', created_at: '2014-11-16 02:56:59 UTC', updated_at: '2014-11-16 02:56:59 UTC')
Attraction.create(id: '3', area_id: '2', name: 'asd', description: 'adfjk', cost: Money.new(123_00), image: 'aldfsjk', link: 'sdglkjj', created_at: '2014-11-16 03:05:21 UTC', updated_at: '2014-11-16 03:05:21 UTC')
Attraction.create(id: '4', area_id: '2', name: 'asdff', description: 'sdfjlk;9io', cost: Money.new(79_00), image: 'sdfglkj', link: 'pol;hjsd', created_at: '2014-11-16 03:05:36 UTC', updated_at: '2014-11-16 03:05:36 UTC')
Attraction.create(id: '5', area_id: '3', name: 'sfiohu', description: ';lsdjgfg', cost: Money.new(13_00), image: 'psidfgj', link: 'spobk', created_at: '2014-11-16 03:06:02 UTC', updated_at: '2014-11-16 03:06:02 UTC')
Attraction.create(id: '6', area_id: '3', name: 'odsfkj', description: 'pj;klsdjf', cost: Money.new(123_00), image: 'asdfjk', link: ';slkcv', created_at: '2014-11-16 03:07:03 UTC', updated_at: '2014-11-16 03:07:03 UTC')
Attraction.create(id: '7', area_id: '3', name: 'pkdf', description: ';lsdkf;ls', cost: Money.new(29_00), image: 'lsk;djf', link: 'psiduugj', created_at: '2014-11-16 03:07:11 UTC', updated_at: '2014-11-16 03:07:11 UTC')
Attraction.create(id: '8', area_id: '4', name: 'steal a car', description: 'whoopsie', cost: Money.new(12_50), image: 'dearth', link: 'lskdjflkw;djf', created_at: '2014-11-17 08:10:22 UTC', updated_at: '2014-11-17 08:10:22 UTC')
Attraction.create(id: '9', area_id: '4', name: 'sit in a car', description: 'show stuff', cost: Money.new(1_00), image: 'lwdkjflskj', link: ';lwkdf;lskfj', created_at: '2014-11-17 08:10:38 UTC', updated_at: '2014-11-17 08:10:38 UTC')
Attraction.create(id: '10', area_id: '5', name: 'ride the luggage buggy', description: '/sgnlskfg', cost: Money.new(12_20), image: 'slfgn', link: 'slf', created_at: '2014-11-17 08:11:23 UTC', updated_at: '2014-11-17 08:11:23 UTC')
