// String API_KEY = "b9c0e4e5d0b8e7b8e8c8e6e6";
/*

SafeArea(
      child: Column(
        children: [
          const Center(
            child: Text('Forecast report', style: AppStyles.h1),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today', style: AppStyles.largeSubtitle),
                Text(formatteddate(), style: AppStyles.largeSubtitle),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 7,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      color:
                          index == 0 ? AppColors.lightBlue : Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(getWeatherImage(1000), height: 50),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('14:00', style: AppStyles.h3),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text('32°C', style: AppStyles.h2),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Next forecast', style: AppStyles.largeSubtitle),
                Icon(Icons.calendar_month_outlined, color: AppColors.white),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: 7,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Container(
                      height: 100,
                      // width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Friday', style: AppStyles.h2),
                                Text('May,28', style: AppStyles.largeSubtitle),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  '32°C',
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white))),
                          Expanded(
                              child: Image.asset(getWeatherImage(1000),
                                  height: 80)),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    */