import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCar extends StatefulWidget {
  const BookCar({Key? key}) : super(key: key);

  @override
  State<BookCar> createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  int? currentPage, item = 1;
  bool isActive = false, select1 = false, select2 = false, select3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade300),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    //Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade800,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300),
                                    ),
                                    child: const Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300),
                                    ),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Model',
                        style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Brand Name',
                        style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                              isActive = true;
                            });
                          },
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Image.asset(
                                'assets/images/bmw.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Image.asset(
                                'assets/images/bmw2.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(microseconds: 150),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            height: 8,
                            width: isActive ? 20 : 8,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.blueGrey.shade800
                                  : Colors.blueGrey.shade400,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  select1 = true;
                                  select2 = false;
                                  select3 = false;
                                });
                              },
                              child: Container(
                                height: 110,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: select1
                                        ? Colors.blueGrey.shade800
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                      color: select1
                                          ? Colors.blueGrey.shade800
                                          : Colors.blueGrey.shade700,
                                      width: select1 ? 1 : 0,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '1 Day',
                                      style: TextStyle(
                                        color: select1
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      '4500',
                                      style: TextStyle(
                                        color: select1
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Taka',
                                      style: TextStyle(
                                        color: select1
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  select1 = false;
                                  select2 = true;
                                  select3 = false;
                                });
                              },
                              child: Container(
                                height: 110,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: select2
                                        ? Colors.blueGrey.shade800
                                        : Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                      color: select2
                                          ? Colors.blueGrey.shade800
                                          : Colors.blueGrey.shade700,
                                      width: select2 ? 1 : 0,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '2 Day',
                                      style: TextStyle(
                                        color: select2
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      '8500',
                                      style: TextStyle(
                                        color: select2
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Taka',
                                      style: TextStyle(
                                        color: select2
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  select2 = false;
                                  select3 = true;
                                  select1 = false;
                                });
                              },
                              child: Container(
                                height: 110,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: select3
                                        ? Colors.blueGrey.shade800
                                        : Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                      color: select3
                                          ? Colors.blueGrey.shade800
                                          : Colors.blueGrey.shade700,
                                      width: select3 ? 1 : 0,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3+ Day',
                                      style: TextStyle(
                                        color: select3
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      '4000',
                                      style: TextStyle(
                                        color: select3
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Taka',
                                      style: TextStyle(
                                        color: select3
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
