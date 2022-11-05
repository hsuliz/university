const fumosPriceMap = {
    "Cirno": 16500,
    "Reimu": 4400,
    "Reisen": 4750,
    "Patchouli": 5600
}

const calculatePrice = (position) => {
    const [latitude, longitude] = [position.coords.latitude, position.coords.longitude]
    const [prodPrice, delPrice] = calculating(latitude, longitude)
    const totalPrice = Number(prodPrice) + Number(delPrice)
    document.getElementById("prodPrice").innerText = prodPrice.toString()
    document.getElementById("delPrice").innerText = delPrice.toString()
    document.getElementById("totalPrice").innerText = totalPrice.toString()
};

const locationError = (error) => {
    console.log(error.message)
};

const calculating = (lat1, lon1) => {
    // some random japan location
    const [lat2, lon2] = [35.55724734257086, 137.74741764337156]

    const calcDelPrice = () => {
        const distance = () => {
            const r = 6371 //radios of Earth
            const p = 0.017453292519943295 //pi/180
            const a = 0.5 -
                Math.cos((lat2 - lat1) * p) / 2 +
                Math.cos(lat1 * p) *
                Math.cos(lat2 * p) *
                (1 - Math.cos((lon2 - lon1) * p)) / 2
            return 2 * r * Math.asin(Math.sqrt(a))
        };
        if (distance() < 200) {
            return Number(20)
        } else {
            return Number((distance() / 2).toFixed(0))
        }
    }

    const calcProdPrice = () => {
        return fumosPriceMap[document.title]
    }

    return [calcProdPrice(), calcDelPrice()]
};

navigator.geolocation.getCurrentPosition(calculatePrice, locationError)