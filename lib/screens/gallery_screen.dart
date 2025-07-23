import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:urban_hunt/widget/loading_icon.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key, required this.images});

  final List<dynamic> images;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final PageController _pageController = PageController();

  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PhotoViewGallery.builder(
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            pageController: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentImage = index;
              });
            },
            loadingBuilder: (BuildContext context, ImageChunkEvent? event) {
              return Center(child: LoadingIcon());
            },
            itemCount: widget.images.length,
            builder: (BuildContext context, int index) {
              final String imageUrl = widget.images[index].toString();

              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(imageUrl),
              );
            },
          ),
          Positioned(
            top: 30.0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.inverseSurface.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(Icons.arrow_back_rounded, size: 28.0),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.inverseSurface.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        '${_currentImage + 1} / ${widget.images.length}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: 0.0,
            right: 0.0,
            child: SizedBox(
              height: 80.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                itemBuilder: (BuildContext context, int index) {
                  final String imageUrl = widget.images[index].toString();

                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
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
  }
}
