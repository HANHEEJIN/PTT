// 경유지 좌표 
let coords = 
[	new Tmapv2.LatLng(37.4838073438209,  126.90030547926335),
	new Tmapv2.LatLng(37.48365651769238, 126.90017785344851),
	new Tmapv2.LatLng(37.48348162217934, 126.90003146140172),
	new Tmapv2.LatLng(37.48328517464137, 126.89987775511946),
	new Tmapv2.LatLng(37.48332683483118, 126.89978609563077),
	new Tmapv2.LatLng(37.48306852839039, 126.8996111188275 ),
	new Tmapv2.LatLng(37.48319702401242, 126.89932077271644),
	new Tmapv2.LatLng(37.48329985694881, 126.89906895160718),
	new Tmapv2.LatLng(37.4834226947903,  126.89877027869265),
	new Tmapv2.LatLng(37.48357400498396, 126.89847787451079),
	new Tmapv2.LatLng(37.48333342460482, 126.89832314300577),
	new Tmapv2.LatLng(37.48318674648813, 126.89822980374146),
	new Tmapv2.LatLng(37.48292221430571, 126.89806733812652),
	new Tmapv2.LatLng(37.48280989413686, 126.8979928493504 ),
	new Tmapv2.LatLng(37.48261754475613, 126.8978623411064 ),
	new Tmapv2.LatLng(37.48241455255667, 126.8977404933321 ),
	new Tmapv2.LatLng(37.48220766785032, 126.89761212893394),
	new Tmapv2.LatLng(37.48200151232619, 126.8974810838704 ),
	new Tmapv2.LatLng(37.48177589004172, 126.8973425030712 ),
	new Tmapv2.LatLng(37.48152362325926, 126.89705959388232),
	new Tmapv2.LatLng(37.48135385189068, 126.89688486712363),
	new Tmapv2.LatLng(37.48123161736433, 126.89671244055076),
	new Tmapv2.LatLng(37.48103691280183, 126.89642968440111),
	new Tmapv2.LatLng(37.48088224311118, 126.89613106513067),
	new Tmapv2.LatLng(37.48080987461388, 126.89593794608161),
	new Tmapv2.LatLng(37.48065762367384, 126.8954782296768 ),
];


// 전체 좌표
let coords1 = [
	{id : '01', lon : '37.4838073438209' , lat : '126.90030547926335', area : '01'},
	{id : '02', lon : '37.48365651769238', lat : '126.90017785344851', area : '02'},
	{id : '03', lon : '37.48348162217934', lat : '126.90003146140172', area : '03'},
	{id : '04', lon : '37.48328517464137', lat : '126.89987775511946', area : '04'},
	{id : '05', lon : '37.48332683483118', lat : '126.89978609563077', area : '05'},
	{id : '06', lon : '37.48306852839039', lat : '126.8996111188275' , area : '06'},
	{id : '07', lon : '37.48319702401242', lat : '126.89932077271644', area : '07'},
	{id : '08', lon : '37.48329985694881', lat : '126.89906895160718', area : '08'},
	{id : '09', lon : '37.4834226947903' , lat : '126.89877027869265', area : '09'},
	{id : '10', lon : '37.48357400498396', lat : '126.89847787451079', area : '10'},
	{id : '11', lon : '37.48333342460482', lat : '126.89832314300577', area : '11'},
	{id : '12', lon : '37.48318674648813', lat : '126.89822980374146', area : '12'},
	{id : '13', lon : '37.48292221430571', lat : '126.89806733812652', area : '13'},	
	{id : '14', lon : '37.48280989413686', lat : '126.8979928493504' , area : '14'},
	{id : '15', lon : '37.48261754475613', lat : '126.8978623411064' , area : '15'},
	{id : '16', lon : '37.48241455255667', lat : '126.8977404933321' , area : '16'},
	{id : '17', lon : '37.48220766785032', lat : '126.89761212893394', area : '17'},
	{id : '18', lon : '37.48200151232619', lat : '126.8974810838704' , area : '18'},
	{id : '19', lon : '37.48177589004172', lat : '126.8973425030712' , area : '19'},
	{id : '20', lon : '37.48152362325926', lat : '126.89705959388232', area : '20'},
	{id : '21', lon : '37.48135385189068', lat : '126.89688486712363', area : '21'},
	{id : '22', lon : '37.48123161736433', lat : '126.89671244055076', area : '22'},
	{id : '23', lon : '37.48103691280183', lat : '126.89642968440111', area : '23'},
	{id : '24', lon : '37.48088224311118', lat : '126.89613106513067', area : '24'},
	{id : '25', lon : '37.48080987461388', lat : '126.89593794608161', area : '25'},
	{id : '26', lon : '37.48065762367384', lat : '126.8954782296768' , area : '26'}	
];


// 전체 좌표
let positions = [
	{id : '01', lon : '37.5838012', lat : '127.0507003', area : '동대문구', type : 'S'},
	{id : '02', lon : '37.5820369', lat : '126.9356665', area : '서대문구', type : 'S'},
	{id : '03', lon : '37.520641' , lat : '126.9139242', area : '영등포구', type : 'S'},
	{id : '04', lon : '37.4959854', lat : '127.0664091', area : '강남구',  type : 'S'},
	{id : '05', lon : '37.5492077', lat : '127.1464824', area : '강동구',  type : 'S'},
	{id : '06', lon : '37.6469954', lat : '127.0147158', area : '강북구',  type : 'S'},
	{id : '07', lon : '37.5657617', lat : '126.8226561', area : '강서구',  type : 'S'},
	{id : '08', lon : '37.4603732', lat : '126.9536086', area : '관악구',  type : 'S'},
	{id : '09', lon : '37.5574120', lat : '127.0796211', area : '광진구',  type : 'S'},
	{id : '10', lon : '37.4954856', lat : '126.858121' , area : '구로구',  type : 'S'},
	{id : '11', lon : '37.4600969', lat : '126.9001546', area : '금천구',  type : 'S'},
	{id : '12', lon : '37.6377533', lat : '127.0754623', area : '노원구',  type : 'S'},
	{id : '13', lon : '37.6658609', lat : '127.0317674', area : '도봉구',  type : 'S'},	
	{id : '14', lon : '37.4965037', lat : '126.9443073', area : '동작구',  type : 'S'},
	{id : '15', lon : '37.5676507', lat : '126.8854549', area : '마포구',  type : 'S'},
	{id : '16', lon : '37.4769528', lat : '127.0378103', area : '서초구',  type : 'S'},
	{id : '17', lon : '37.5506753', lat : '127.0409622', area : '성동구',  type : 'S'},
	{id : '18', lon : '37.606991 ', lat : '127.0232185', area : '성북구',  type : 'S'},
	{id : '19', lon : '37.5177941', lat : '127.1127078', area : '송파구',  type : 'S'},
	{id : '20', lon : '37.5270616', lat : '126.8561534', area : '양천구',  type : 'S'},
	{id : '21', lon : '37.598031' , lat : '127.092931' , area : '중랑구',  type : 'S'},
	{id : '22', lon : '37.5311008', lat : '126.9810742', area : '용산구',  type : 'S'},
	{id : '23', lon : '37.6176125', lat : '126.9227004', area : '은평구',  type : 'S'},
	{id : '24', lon : '37.5990998', lat : '126.9861493', area : '종로구',  type : 'S'},
	{id : '25', lon : '37.5579452', lat : '126.9941904', area : '중구',    type : 'S'},
	// ***** *****  ***** 인천 좌표 ***** ***** *****
	{id : '01', lon : '37.74722', lat : '126.48556', area : '강화군', type : 'I'},
	{id : '02', lon : '37.52306', lat : '126.74472', area : '계양구', type : 'I'},
	{id : '03', lon : '37.4972',  lat : '126.71107', area : '부평구', type : 'I'},
	{id : '04', lon : '37.41831', lat : '126.7184',  area : '남동구', type : 'I'},
	{id : '05', lon : '37.41911', lat : '126.66489', area : '연수구', type : 'I'},
	{id : '06', lon : '37.23361', lat : '126.12305', area : '옹진군', type : 'I'},
	{id : '07', lon : '37.48375', lat : '126.6369',  area : '동구',  type : 'I'},
	{id : '08', lon : '37.46362', lat : '126.65',    area : '남구',  type : 'I'},	
	{id : '09', lon : '37.55233', lat : '126.65543', area : '서구',  type : 'I'},
	{id : '10', lon : '37.47353', lat : '126.62151', area : '중구',  type : 'I'},
	{id : '10', lon : '37.47354', lat : '126.62152', area : '중구1',  type : 'I'},
	{id : '10', lon : '37.47355', lat : '126.62153', area : '중구2',  type : 'I'},
	{id : '10', lon : '37.47356', lat : '126.62154', area : '중구3',  type : 'I'},
	{id : '10', lon : '37.47357', lat : '126.62155', area : '중구4',  type : 'I'},
	
	// ***** ***** ***** 경기도 좌표 ***** ***** *****
	{id : '01', lon : '37.65217', lat : '127.2401',  area : '남양주시', type : 'K'},
	{id : '02', lon : '37.91889', lat : '127.06897', area : '동두천시', type : 'K'},
	{id : '03', lon : '37.73865', lat : '127.0477',  area : '의정부시', type : 'K'},
	{id : '04', lon : '37.8308',  lat : '127.51522', area : '가평군',  type : 'K'},
	{id : '05', lon : '38.09404', lat : '127.07577', area : '연천군',  type : 'K'},
	{id : '06', lon : '37.4888',  lat : '127.49222', area : '양평군',  type : 'K'},
	{id : '07', lon : '37.65639', lat : '126.835',   area : '고양시',  type : 'K'},
	{id : '08', lon : '37.43407', lat : '126.99989', area : '과천시',  type : 'K'},
	{id : '09', lon : '37.44435', lat : '126.86499', area : '광명시',  type : 'K'},
	{id : '10', lon : '37.16667', lat : '126.91667', area : '광주시',  type : 'K'},
	{id : '11', lon : '37.5986',  lat : '127.1394',  area : '구리시',  type : 'K'},
	{id : '12', lon : '37.34261', lat : '126.92149', area : '군포시',  type : 'K'},
	{id : '13', lon : '37.59417', lat : '126.7425',  area : '김포시',  type : 'K'},
	{id : '14', lon : '37.49889', lat : '126.78306', area : '부천시',  type : 'K'},
	{id : '15', lon : '37.41875', lat : '127.12877', area : '성남시',  type : 'K'},
	{id : '16', lon : '37.28586', lat : '127.00993', area : '수원시',  type : 'K'},	
	{id : '17', lon : '37.39067', lat : '126.7888',  area : '시흥시',  type : 'K'},
	{id : '18', lon : '37.31693', lat : '126.83048', area : '안산시',  type : 'K'},
	{id : '19', lon : '37.03789', lat : '127.30057', area : '안성시',  type : 'K'},
	{id : '20', lon : '37.3925',  lat : '126.92694', area : '안양시',  type : 'K'},
	{id : '21', lon : '37.81732', lat : '127.046',   area : '양주시',  type : 'K'},
	{id : '22', lon : '37.29562', lat : '127.63668', area : '여주시',  type : 'K'},	
	{id : '23', lon : '37.15222', lat : '127.07056', area : '오산시',  type : 'K'},
	{id : '24', lon : '37.23825', lat : '127.17795', area : '용인시',  type : 'K'},
	{id : '25', lon : '37.345',   lat : '126.97575', area : '의왕시',  type : 'K'},
	{id : '26', lon : '37.27917', lat : '127.4425' , area : '이천시',  type : 'K'},
	{id : '27', lon : '37.75952', lat : '126.77772', area : '파주시',  type : 'K'},
	{id : '28', lon : '36.99472', lat : '127.08889', area : '평택시',  type : 'K'},
	{id : '29', lon : '37.8937',  lat : '127.20028', area : '포천시',  type : 'K'},
	{id : '30', lon : '37.53895', lat : '127.2125',  area : '하남시',  type : 'K'},
	{id : '31', lon : '37.20025', lat : '126.82909', area : '화성시',  type : 'K'}
	
];

// 전체 좌표
let posUserInfo = [
	{id : '01', lon : '37.5838012', lat : '127.0507003', area : '동대문구', type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '02', lon : '37.5820369', lat : '126.9356665', area : '서대문구', type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '03', lon : '37.520641' , lat : '126.9139242', area : '영등포구', type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '04', lon : '37.4959854', lat : '127.0664091', area : '강남구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '05', lon : '37.5492077', lat : '127.1464824', area : '강동구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '06', lon : '37.6469954', lat : '127.0147158', area : '강북구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '07', lon : '37.5657617', lat : '126.8226561', area : '강서구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '08', lon : '37.4603732', lat : '126.9536086', area : '관악구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '09', lon : '37.5574120', lat : '127.0796211', area : '광진구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '10', lon : '37.4954856', lat : '126.858121' , area : '구로구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '11', lon : '37.4600969', lat : '126.9001546', area : '금천구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '12', lon : '37.6377533', lat : '127.0754623', area : '노원구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '13', lon : '37.6658609', lat : '127.0317674', area : '도봉구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},	
	{id : '14', lon : '37.4965037', lat : '126.9443073', area : '동작구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '15', lon : '37.5676507', lat : '126.8854549', area : '마포구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '16', lon : '37.4769528', lat : '127.0378103', area : '서초구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '17', lon : '37.5506753', lat : '127.0409622', area : '성동구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '18', lon : '37.606991 ', lat : '127.0232185', area : '성북구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '19', lon : '37.5177941', lat : '127.1127078', area : '송파구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '20', lon : '37.5270616', lat : '126.8561534', area : '양천구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '21', lon : '37.598031' , lat : '127.092931' , area : '중랑구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '22', lon : '37.5311008', lat : '126.9810742', area : '용산구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '23', lon : '37.6176125', lat : '126.9227004', area : '은평구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '24', lon : '37.5990998', lat : '126.9861493', area : '종로구',  type : 'S', user_id : 'ADMIN', topic : '/ptt/chat/107'},
	{id : '25', lon : '37.5579452', lat : '126.9941904', area : '중구',   type : 'S', user_id : 'ADMIN', topic : 'ptt/chat/107'},
	// ***** *****  ***** 인천 좌표 ***** ***** *****
	{id : '01', lon : '37.74722', lat : '126.48556', area : '강화군', type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '02', lon : '37.52306', lat : '126.74472', area : '계양구', type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '03', lon : '37.4972',  lat : '126.71107', area : '부평구', type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '04', lon : '37.41831', lat : '126.7184',  area : '남동구', type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '05', lon : '37.41911', lat : '126.66489', area : '연수구', type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '06', lon : '37.23361', lat : '126.12305', area : '옹진군', type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '07', lon : '37.48375', lat : '126.6369',  area : '동구',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '08', lon : '37.46362', lat : '126.65',    area : '남구',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},	
	{id : '09', lon : '37.55233', lat : '126.65543', area : '서구',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '10', lon : '37.47353', lat : '126.62151', area : '중구',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '10', lon : '37.47354', lat : '126.62152', area : '중구1',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '10', lon : '37.47355', lat : '126.62153', area : '중구2',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '10', lon : '37.47356', lat : '126.62154', area : '중구3',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	{id : '10', lon : '37.47357', lat : '126.62155', area : '중구4',  type : 'I', user_id : 'ADMIN', topic : '/ptt/noti/noti'},
	
	// ***** ***** ***** 경기도 좌표 ***** ***** *****
	{id : '01', lon : '37.65217', lat : '127.2401',  area : '남양주시', type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '02', lon : '37.91889', lat : '127.06897', area : '동두천시', type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '03', lon : '37.73865', lat : '127.0477',  area : '의정부시', type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '04', lon : '37.8308',  lat : '127.51522', area : '가평군',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '05', lon : '38.09404', lat : '127.07577', area : '연천군',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '06', lon : '37.4888',  lat : '127.49222', area : '양평군',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '07', lon : '37.65639', lat : '126.835',   area : '고양시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '08', lon : '37.43407', lat : '126.99989', area : '과천시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '09', lon : '37.44435', lat : '126.86499', area : '광명시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '10', lon : '37.16667', lat : '126.91667', area : '광주시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '11', lon : '37.5986',  lat : '127.1394',  area : '구리시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '12', lon : '37.34261', lat : '126.92149', area : '군포시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '13', lon : '37.59417', lat : '126.7425',  area : '김포시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '14', lon : '37.49889', lat : '126.78306', area : '부천시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '15', lon : '37.41875', lat : '127.12877', area : '성남시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '16', lon : '37.28586', lat : '127.00993', area : '수원시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},	
	{id : '17', lon : '37.39067', lat : '126.7888',  area : '시흥시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '18', lon : '37.31693', lat : '126.83048', area : '안산시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '19', lon : '37.03789', lat : '127.30057', area : '안성시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '20', lon : '37.3925',  lat : '126.92694', area : '안양시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '21', lon : '37.81732', lat : '127.046',   area : '양주시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '22', lon : '37.29562', lat : '127.63668', area : '여주시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},	
	{id : '23', lon : '37.15222', lat : '127.07056', area : '오산시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '24', lon : '37.23825', lat : '127.17795', area : '용인시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '25', lon : '37.345',   lat : '126.97575', area : '의왕시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '26', lon : '37.27917', lat : '127.4425' , area : '이천시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '27', lon : '37.75952', lat : '126.77772', area : '파주시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '28', lon : '36.99472', lat : '127.08889', area : '평택시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '29', lon : '37.8937',  lat : '127.20028', area : '포천시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '30', lon : '37.53895', lat : '127.2125',  area : '하남시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'},
	{id : '31', lon : '37.20025', lat : '126.82909', area : '화성시',  type : 'K', user_id : 'ADMIN', topic : '/ptt/load/164'}
	
];

let positions1 = [
	{id : '01', lonlat : new Tmapv2.LatLng(37.5838012, 127.0507003), area : '동대문구'},
	{id : '02', lonlat : new Tmapv2.LatLng(37.5820369, 126.9356665), area : '서대문구'},
	{id : '03', lonlat : new Tmapv2.LatLng(37.520641,  126.9139242), area : '영등포구'},
	{id : '04', lonlat : new Tmapv2.LatLng(37.4959854, 127.0664091), area : '강남구'},
	{id : '05', lonlat : new Tmapv2.LatLng(37.5492077, 127.1464824), area : '강동구'},
	{id : '06', lonlat : new Tmapv2.LatLng(37.6469954, 127.0147158), area : '강북구'},
	{id : '07', lonlat : new Tmapv2.LatLng(37.5657617, 126.8226561), area : '강서구'},
	{id : '08', lonlat : new Tmapv2.LatLng(37.4603732, 126.9536086), area : '관악구'},
	{id : '09', lonlat : new Tmapv2.LatLng(37.5574120, 127.0796211), area : '광진구'},
	{id : '10', lonlat : new Tmapv2.LatLng(37.4954856, 126.858121) , area : '구로구'},
	{id : '11', lonlat : new Tmapv2.LatLng(37.4600969, 126.9001546), area : '금천구'},
	{id : '12', lonlat : new Tmapv2.LatLng(37.6377533, 127.0754623), area : '노원구'},
	{id : '13', lonlat : new Tmapv2.LatLng(37.6658609, 127.0317674), area : '도봉구'},	
	{id : '14', lonlat : new Tmapv2.LatLng(37.4965037, 126.9443073), area : '동작구'},
	{id : '15', lonlat : new Tmapv2.LatLng(37.5676507, 126.8854549), area : '마포구'},
	{id : '16', lonlat : new Tmapv2.LatLng(37.4769528, 127.0378103), area : '서초구'},
	{id : '17', lonlat : new Tmapv2.LatLng(37.5506753, 127.0409622), area : '성동구'},
	{id : '18', lonlat : new Tmapv2.LatLng(37.606991,  127.0232185), area : '성북구'},
	{id : '19', lonlat : new Tmapv2.LatLng(37.5177941, 127.1127078), area : '송파구'},
	{id : '20', lonlat : new Tmapv2.LatLng(37.5270616, 126.8561534), area : '양천구'},
	{id : '21', lonlat : new Tmapv2.LatLng(37.598031,  127.092931) , area : '중랑구'},
	{id : '22', lonlat : new Tmapv2.LatLng(37.5311008, 126.9810742), area : '용산구'},
	{id : '23', lonlat : new Tmapv2.LatLng(37.6176125, 126.9227004), area : '은평구'},
	{id : '24', lonlat : new Tmapv2.LatLng(37.5990998, 126.9861493), area : '종로구'},
	{id : '25', lonlat : new Tmapv2.LatLng(37.5579452, 126.9941904), area : '중구'}	
];

let position_ = []
