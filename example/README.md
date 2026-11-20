# FlartDart Example Showcase

A comprehensive 9-category interactive widget catalog showcasing the FlartDart framework across mobile, tablet, and desktop views.

## Running the Showcase

From the root of this repository, start the development server using `build_runner`:

```bash
dart run build_runner serve example:8080
```

Or using the FlartDart CLI:

```bash
flartdart run
```

Then open `http://localhost:8080` in any modern web browser.

## Features Demonstrated

1. **Structure & Layout**: Strict box-sizing, containers, constraints, decorated boxes, dividers, and cards.
2. **Arrangement & Positioning**: Rows, columns, multi-layer stacks, alignments, and wrap layouts.
3. **Buttons & Gestures**: Elevated, outlined, text, and icon buttons, with InkWell and GestureDetector surfaces.
4. **Texts & Typography**: Hierarchy, line clamping with ellipsis, selectable text, RichText, and editable text.
5. **Inputs & Form Validation**: Material text fields, form validators, dropdowns, sliders, and selection toggles.
6. **Dialogs & Feedback**: Modal dialogs, alert dialogs, tooltips, snackbars, and progress indicators.
7. **Animation & Transitions**: Implicit container animations, opacity, crossfade, rotation, scale, and slide.
8. **Media & Web Embeds**: HTML5 video, audio, YouTube embeds, map embeds, anchor links, and native VDOM elements.
9. **Utility & Reactive Builders**: ValueListenableBuilder, FutureBuilder, StreamBuilder, Provider, Consumer, and ViewModelBuilder.
10. **Multi-View Responsiveness**: Adaptive UI responding seamlessly across Mobile (<600px), Tablet (600–1023px), and Desktop (≥1024px).
