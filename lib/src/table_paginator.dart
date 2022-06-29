import 'package:flutter/material.dart';
import 'package:table_paginator/src/paginator_button.dart';

class TablePaginator extends StatelessWidget {
  const TablePaginator({
    super.key,
    this.itemsPerPageLabel = 'Items per page:',
    this.ofLabel = 'of',
    this.pageSize = 25,
    this.pageIndex = 0,
    this.onPageSizeChanged,
    this.pageSizeOptions = const [5, 10, 25, 100],
    this.length = 0,
    this.onSkipPreviousPressed,
    this.onSkipNextPressed,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  final String itemsPerPageLabel;
  final String ofLabel;
  final int pageSize;
  final List<int> pageSizeOptions;
  final Function(int)? onPageSizeChanged;
  final int length;
  final int pageIndex;
  final void Function()? onSkipPreviousPressed;
  final void Function(int lastPageIndex)? onSkipNextPressed;
  final void Function() onPreviousPressed;
  final void Function() onNextPressed;

  @override
  Widget build(BuildContext context) {
    final lastPage = length == 0 ? 0 : (length / pageSize).ceil() - 1;
    assert(pageIndex <= lastPage);

    return Align(
      alignment: Alignment.bottomRight,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Visibility(
            visible: onPageSizeChanged != null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  itemsPerPageLabel,
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<int>(
                    focusColor: Colors.transparent,
                    value: pageSize,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        onPageSizeChanged?.call(newValue);
                      }
                    },
                    items:
                        pageSizeOptions.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Visibility(
                      visible: length == 0,
                      child: Text(
                        '0',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Visibility(
                      visible: length != 0,
                      child: Text(
                        _generateRangeText(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Text(
                      ' $ofLabel ',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      length.toString(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: onSkipPreviousPressed != null,
                child: PaginatorButton(
                  onPressed: pageIndex != 0 ? onSkipPreviousPressed : null,
                  icon: const Icon(Icons.skip_previous),
                ),
              ),
              PaginatorButton(
                onPressed: pageIndex != 0 ? onPreviousPressed : null,
                icon: const Icon(Icons.navigate_before),
              ),
              PaginatorButton(
                onPressed: pageIndex < lastPage ? onNextPressed : null,
                icon: const Icon(Icons.navigate_next),
              ),
              Visibility(
                visible: onSkipNextPressed != null,
                child: PaginatorButton(
                  onPressed: pageIndex < lastPage
                      ? () => onSkipNextPressed?.call(lastPage)
                      : null,
                  icon: const Icon(Icons.skip_next),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _generateRangeText() {
    final first = pageIndex * pageSize;
    final lastItemOfPage = first + pageSize;
    final second = lastItemOfPage > length ? length : lastItemOfPage;
    return '$first-$second';
  }
}
