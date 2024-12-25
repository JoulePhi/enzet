import 'package:enzet/app/modules/stores/model/store_model.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:enzet/theme/styles.dart';

class StoreCard extends StatelessWidget {
  final StoreModel store;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isSelected;

  const StoreCard({
    super.key,
    required this.store,
    required this.onTap,
    required this.onLongPress,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (store.name == 'add' && store.code == '-') {
      return GestureDetector(
          onTap: onTap,
          onDoubleTap: onLongPress,
          child: DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [6, 3, 2, 3],
              color: Colors.grey,
              strokeWidth: 2,
              radius: const Radius.circular(AppStyle.mediumRadius),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppStyle.mediumRadius)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: 48,
                    ),
                  ),
                ),
              )));
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    store.image != null && store.image!.isNotEmpty
                        ? Image.network(
                            store.image!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/logoipsum.png', // Gambar placeholder jika gagal load
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/logoipsum.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.contain,
                          ),
                    const SizedBox(height: 12),
                    Text(
                      store.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.blue : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isSelected)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
