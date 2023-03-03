import 'package:flutter/material.dart';

class MenuCategoryItem extends StatelessWidget {
  const MenuCategoryItem({
    Key? key,
  required this.title,
  required this.items}) : super(key: key);

  final String title;
  final List items;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),),
        ...items
      ],
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
  required this.image,
  required this.title,
  required this.price}) : super(key: key);

  final String image, title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(image),
        ),
        const SizedBox(width:  16,),
        Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.black45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Shortbread, chocolate turtle cookies, and red velvet.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Text("\$\$"),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: CircleAvatar(
                          radius: 2,
                          backgroundColor: Colors.black38,
                        ),
                      ),
                      const Text("Chinese"),
                      const Spacer(),
                      Text(
                        "USD$price",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF22A45D),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ) )
      ],
    );
  }
}


