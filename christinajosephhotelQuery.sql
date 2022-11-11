-- 1. Write a query that returns a list of reservations that end in July 2023
-- including the name of the guest, the room number(s), and the reservation dates.
SELECT 
	rm.roomId, 
    gt.firstName, 
    gt.lastName, 
    rn.startDate, 
    rn.endDate
FROM guests gs 
INNER JOIN guest gt
ON gs.guestId = gt.guestId
INNER JOIN reservation rn 
ON rn.reservationId = gs.reservationId
INNER JOIN roomsReserved rr
ON rr.reservationId = rn.reservationId
INNER JOIN room rm
ON rm.roomId = rr.roomId
WHERE MONTH(rn.endDate)=7 AND YEAR(rn.endDate)=2023;

-- 2. Write a query that returns a list of reservations for rooms with
-- a jacuzzi, displaying the guest's name, the room number, and the dates
-- of the reservation.
SELECT 
	rm.roomId, 
    gt.firstName, 
    gt.lastName, 
    rn.startDate, 
    rn.endDate
FROM guests gs 
INNER JOIN guest gt
ON gs.guestId = gt.guestId
INNER JOIN reservation rn 
ON rn.reservationId = gs.reservationId
INNER JOIN roomsReserved rr
ON rr.reservationId = rn.reservationId
INNER JOIN room rm
ON rm.roomId = rr.roomId
INNER JOIN roomAmenities ra
ON ra.roomId = rm.roomId
INNER JOIN amenity ay
ON ay.amenityId = ra.amenityId
WHERE ay.name = 'Jacuzzi';


-- 3. Write a query that returns all rooms reserved for a specific guest
-- including the guest's name, the room(s) reserved, the starting date of
-- the reservation, and how many people were included in the reservation.
-- (choose a guest's name from the existing data.)
SELECT DISTINCT
	rm.roomId, 
    gt.firstName, 
    gt.lastName, 
    rn.startDate, 
    rn.endDate,
    gs.quantityAdults + gs.quantityChildren AS quantity_people
FROM guests gs 
INNER JOIN guest gt
ON gs.guestId = gt.guestId
INNER JOIN reservation rn 
ON rn.reservationId = gs.reservationId
INNER JOIN roomsReserved rr
ON rr.reservationId = rn.reservationId
INNER JOIN room rm
ON rm.roomId = rr.roomId
INNER JOIN roomAmenities ra
ON ra.roomId = rm.roomId
INNER JOIN amenity ay
ON ay.amenityId = ra.amenityId
WHERE gt.firstName = 'Mark' AND gt.lastName = 'Simmer';


-- 4. Write a query that returns a list of rooms, reservation ID and per-room
-- cost for each reservation. The results should include all rooms, whether
-- or not there is a reservation associated with the room.
SELECT
    rm.roomId,
    rn.reservationId,
   CASE WHEN (gs.quantityAdults - rt.standardOccupancy)>0  -- when there are extra adults
		THEN rm.basePrice*DATEDIFF(rn.endDate, rn.startDate)+(gs.quantityAdults - rt.standardOccupancy)*rt.extraPersonCost -- add the extra charge per person
        ELSE rm.basePrice*DATEDIFF(rn.endDate, rn.startDate) END AS total_room_cost
FROM room rm  -- Left table
LEFT JOIN roomsReserved rr 
ON rr.roomId = rm.roomId 
LEFT JOIN reservation rn
ON rn.reservationId = rr.reservationId
LEFT JOIN roomType rt
ON rt.roomTypeId = rm.roomTypeId
LEFT JOIN guests gs
ON gs.reservationId = rn.reservationId
ORDER BY roomId;

-- 5. Write a query that returns all rooms with a capacity of three or more and 
-- that are reserved on any date in April 2023.
SELECT 
	rm.roomId,
    rt.maximumOccupancy,
    rn.reservationId,
    rn.startDate,
    rn.endDate
FROM room rm
INNER JOIN roomsReserved rr
ON rr.roomId = rm.roomId
INNER JOIN reservation rn 
ON rn.reservationId = rr.reservationId 
INNER JOIN roomType rt
ON rt.roomTypeId = rm.roomTypeId
WHERE rt.maximumOccupancy>=4 AND MONTH(rn.startDate)=4;


-- 6. Write a query that returns a list of all guest names and the no. of reservations
-- per guest, sorted starting with the guest with the most reservations and then by the 
-- guest's last name.
SELECT 
    gt.firstName,
    gt.lastName,
    count(gs.guestId) reservationCount
FROM guest gt
INNER JOIN guests gs
ON gs.guestId = gt.guestId
INNER JOIN reservation rn 
ON rn.reservationId = gs.reservationId
GROUP BY gt.guestId
ORDER BY reservationCount DESC, gt.lastName;


-- 7. Write a query that displays the name, address and phone number of
-- a guest based on their phone number. (Choose a phone number from the
-- existing data).
SELECT 
	gt.firstName,
    gt.lastName,
    gt.address,
    gt.city,
    gt.stateAbbr,
    gt.zip,
    gt.phone
FROM guest gt
WHERE gt.phone = '(478) 277-9632';




