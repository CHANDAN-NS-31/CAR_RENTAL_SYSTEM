document.addEventListener('DOMContentLoaded', () => {
    const carSelect = document.getElementById('car');
    const locationSelect = document.getElementById('location');

    // Fetch cars
    fetch('http://localhost:3000/cars')
        .then(response => response.json())
        .then(data => {
            data.forEach(car => {
                const option = document.createElement('option');
                option.value = car.car_id;
                option.textContent = `${car.make} ${car.model} (${car.year}) - $${car.daily_rate}/day`;
                carSelect.appendChild(option);
            });
        });

    // Fetch locations
    fetch('http://localhost:3000/locations')
        .then(response => response.json())
        .then(data => {
            data.forEach(location => {
                const option = document.createElement('option');
                option.value = location.location_id;
                option.textContent = location.name;
                locationSelect.appendChild(option);
            });
        });

    // Handle form submission
    document.getElementById('rentCarForm').addEventListener('submit', (e) => {
        e.preventDefault();
        const formData = new FormData(e.target);
        const data = Object.fromEntries(formData);

        fetch('http://localhost:3000/rentals', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(data => {
            alert('Car rented successfully!');
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error renting car: ' + error.message);
        });
    });
});
