import 'package:basic_custom_dropdown/drop_down_item.dart';
import 'package:flutter/material.dart';

class CustomMultiSelectDropdown<T> extends StatefulWidget {
  final List<DropdownItem<T>> items;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onChanged;
  final String hintText;
  final double maxHeight;
  final bool isExpanded;
  const CustomMultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    required this.hintText,
    required this.maxHeight,
    required this.isExpanded,
  });

  @override
  State<CustomMultiSelectDropdown<T>> createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState<T>
    extends State<CustomMultiSelectDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _removeOverlay();
  }

  void _toggleDropDown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _addOverlay();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _addOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                constraints: BoxConstraints(maxHeight: widget.maxHeight),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final isSelected = widget.selectedValues.contains(
                      item.value,
                    );

                    return InkWell(
                      onTap: () {
                        final newSelectedValues = List<T>.from(
                          widget.selectedValues,
                        );
                        if (isSelected) {
                          newSelectedValues.remove(item.value);
                        } else {
                          newSelectedValues.add(item.value);
                        }
                        widget.onChanged(newSelectedValues);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.transparent,
                          border: Border(
                            bottom: index < widget.items.length - 1
                                ? BorderSide(color: Colors.grey.shade200)
                                : BorderSide.none,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(4),
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropDown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: widget.selectedValues.isEmpty
                    ? Text(
                        widget.hintText,
                        style: TextStyle(color: Colors.grey.shade600),
                      )
                    : Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.selectedValues.map((value) {
                          final item = widget.items.firstWhere(
                            (item) => item.value == value,
                            orElse: () => DropdownItem<T>(
                              value: value,
                              label: value.toString(),
                            ),
                          );

                          return Chip(
                            label: Text(item.label),
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            labelStyle: const TextStyle(color: Colors.blue),
                            deleteIcon: Icon(Icons.close, size: 16),
                            onDeleted: () {
                              final newSelectedValues = List<T>.from(
                                widget.selectedValues,
                              );
                              newSelectedValues.remove(value);
                              widget.onChanged(newSelectedValues);
                            },
                          );
                        }).toList(),
                      ),
              ),
              Icon(_isOpen? Icons.arrow_drop_up : Icons.arrow_drop_down,color: Colors.grey.shade600,)
            ],
          ),
        ),
      ),
    );
  }
}
