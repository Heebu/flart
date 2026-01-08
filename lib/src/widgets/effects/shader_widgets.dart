import '../../../flartdart.dart';

/// Base shader widget with customizable shader code
class ShaderWidget extends Widget {
  final Widget? child;
  final String fragmentShader;
  final double? width;
  final double? height;
  final Map<String, dynamic>? uniforms;
  final bool animate;

  ShaderWidget({
    this.child,
    required this.fragmentShader,
    this.width,
    this.height,
    this.uniforms,
    this.animate = false,
  });

  @override
  String render(BuildContext context) {
    final id = 'shader_${DateTime.now().microsecondsSinceEpoch}';
    final w = width ?? 300;
    final h = height ?? 300;

    return '''
      <div id="$id" style="position: relative; width: ${w}px; height: ${h}px;">
        <canvas id="${id}_canvas" width="$w" height="$h" style="position: absolute; top: 0; left: 0;"></canvas>
        ${child != null ? '<div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">${child!.render(context)}</div>' : ''}
      </div>
      
      <script>
        (function() {
          const canvas = document.getElementById('${id}_canvas');
          const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
          
          if (!gl) {
            console.error('WebGL not supported');
            return;
          }
          
          // Vertex shader
          const vertexShaderSource = \`
            attribute vec2 position;
            void main() {
              gl_Position = vec4(position, 0.0, 1.0);
            }
          \`;
          
          // Fragment shader
          const fragmentShaderSource = \`
            precision mediump float;
            uniform vec2 resolution;
            uniform float time;
            ${uniforms?.entries.map((e) => 'uniform ${_getUniformType(e.value)} ${e.key};').join('\n') ?? ''}
            
            $fragmentShader
          \`;
          
          // Compile shaders
          function compileShader(source, type) {
            const shader = gl.createShader(type);
            gl.shaderSource(shader, source);
            gl.compileShader(shader);
            if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
              console.error('Shader compile error:', gl.getShaderInfoLog(shader));
              return null;
            }
            return shader;
          }
          
          const vertexShader = compileShader(vertexShaderSource, gl.VERTEX_SHADER);
          const fragmentShader = compileShader(fragmentShaderSource, gl.FRAGMENT_SHADER);
          
          // Create program
          const program = gl.createProgram();
          gl.attachShader(program, vertexShader);
          gl.attachShader(program, fragmentShader);
          gl.linkProgram(program);
          gl.useProgram(program);
          
          // Set up geometry
          const positions = new Float32Array([-1, -1, 1, -1, -1, 1, 1, 1]);
          const buffer = gl.createBuffer();
          gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
          gl.bufferData(gl.ARRAY_BUFFER, positions, gl.STATIC_DRAW);
          
          const positionLocation = gl.getAttribLocation(program, 'position');
          gl.enableVertexAttribArray(positionLocation);
          gl.vertexAttribPointer(positionLocation, 2, gl.FLOAT, false, 0, 0);
          
          // Get uniform locations
          const resolutionLocation = gl.getUniformLocation(program, 'resolution');
          const timeLocation = gl.getUniformLocation(program, 'time');
          
          // Set resolution
          gl.uniform2f(resolutionLocation, $w, $h);
          
          // Animation loop
          let startTime = Date.now();
          function render() {
            const time = (Date.now() - startTime) / 1000.0;
            gl.uniform1f(timeLocation, time);
            
            gl.clearColor(0, 0, 0, 0);
            gl.clear(gl.COLOR_BUFFER_BIT);
            gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
            
            ${animate ? 'requestAnimationFrame(render);' : ''}
          }
          
          render();
        })();
      </script>
    ''';
  }

  String _getUniformType(dynamic value) {
    if (value is double || value is int) return 'float';
    if (value is List && value.length == 2) return 'vec2';
    if (value is List && value.length == 3) return 'vec3';
    if (value is List && value.length == 4) return 'vec4';
    return 'float';
  }
}

/// Gradient shader widget
class GradientShader extends Widget {
  final Widget? child;
  final List<String> colors;
  final double? width;
  final double? height;
  final String direction;
  final bool animate;

  GradientShader({
    this.child,
    required this.colors,
    this.width,
    this.height,
    this.direction =
        'diagonal', // 'horizontal', 'vertical', 'diagonal', 'radial'
    this.animate = false,
  });

  @override
  String render(BuildContext context) {
    String shader = '';

    if (direction == 'radial') {
      shader = '''
        void main() {
          vec2 uv = gl_FragCoord.xy / resolution;
          float dist = distance(uv, vec2(0.5));
          vec3 color1 = vec3(${_hexToRgb(colors[0])});
          vec3 color2 = vec3(${_hexToRgb(colors.length > 1 ? colors[1] : colors[0])});
          vec3 color = mix(color1, color2, dist * 2.0);
          gl_FragColor = vec4(color, 1.0);
        }
      ''';
    } else if (direction == 'horizontal') {
      shader = '''
        void main() {
          vec2 uv = gl_FragCoord.xy / resolution;
          vec3 color1 = vec3(${_hexToRgb(colors[0])});
          vec3 color2 = vec3(${_hexToRgb(colors.length > 1 ? colors[1] : colors[0])});
          vec3 color = mix(color1, color2, uv.x);
          gl_FragColor = vec4(color, 1.0);
        }
      ''';
    } else if (direction == 'vertical') {
      shader = '''
        void main() {
          vec2 uv = gl_FragCoord.xy / resolution;
          vec3 color1 = vec3(${_hexToRgb(colors[0])});
          vec3 color2 = vec3(${_hexToRgb(colors.length > 1 ? colors[1] : colors[0])});
          vec3 color = mix(color1, color2, uv.y);
          gl_FragColor = vec4(color, 1.0);
        }
      ''';
    } else {
      shader = '''
        void main() {
          vec2 uv = gl_FragCoord.xy / resolution;
          vec3 color1 = vec3(${_hexToRgb(colors[0])});
          vec3 color2 = vec3(${_hexToRgb(colors.length > 1 ? colors[1] : colors[0])});
          vec3 color = mix(color1, color2, (uv.x + uv.y) / 2.0);
          gl_FragColor = vec4(color, 1.0);
        }
      ''';
    }

    return ShaderWidget(
      child: child,
      fragmentShader: shader,
      width: width,
      height: height,
      animate: animate,
    ).render(context);
  }

  String _hexToRgb(String hex) {
    hex = hex.replaceAll('#', '');
    final r = int.parse(hex.substring(0, 2), radix: 16) / 255.0;
    final g = int.parse(hex.substring(2, 4), radix: 16) / 255.0;
    final b = int.parse(hex.substring(4, 6), radix: 16) / 255.0;
    return '$r, $g, $b';
  }
}

/// Animated wave shader
class WaveShader extends Widget {
  final Widget? child;
  final String color;
  final double? width;
  final double? height;
  final double speed;
  final double amplitude;

  WaveShader({
    this.child,
    this.color = '#007bff',
    this.width,
    this.height,
    this.speed = 1.0,
    this.amplitude = 0.1,
  });

  @override
  String render(BuildContext context) {
    final shader = '''
      void main() {
        vec2 uv = gl_FragCoord.xy / resolution;
        float wave = sin(uv.x * 10.0 + time * $speed) * $amplitude;
        float dist = abs(uv.y - 0.5 - wave);
        float alpha = smoothstep(0.02, 0.0, dist);
        vec3 color = vec3(${_hexToRgb(color)});
        gl_FragColor = vec4(color, alpha);
      }
    ''';

    return ShaderWidget(
      child: child,
      fragmentShader: shader,
      width: width,
      height: height,
      animate: true,
    ).render(context);
  }

  String _hexToRgb(String hex) {
    hex = hex.replaceAll('#', '');
    final r = int.parse(hex.substring(0, 2), radix: 16) / 255.0;
    final g = int.parse(hex.substring(2, 4), radix: 16) / 255.0;
    final b = int.parse(hex.substring(4, 6), radix: 16) / 255.0;
    return '$r, $g, $b';
  }
}

/// Ripple effect shader
class RippleShader extends Widget {
  final Widget? child;
  final String color;
  final double? width;
  final double? height;
  final double speed;

  RippleShader({
    this.child,
    this.color = '#007bff',
    this.width,
    this.height,
    this.speed = 1.0,
  });

  @override
  String render(BuildContext context) {
    final shader = '''
      void main() {
        vec2 uv = gl_FragCoord.xy / resolution;
        vec2 FDCenter = vec2(0.5);
        float dist = distance(uv, FDCenter);
        float ripple = sin(dist * 20.0 - time * $speed * 5.0) * 0.5 + 0.5;
        vec3 color = vec3(${_hexToRgb(color)});
        gl_FragColor = vec4(color * ripple, ripple);
      }
    ''';

    return ShaderWidget(
      child: child,
      fragmentShader: shader,
      width: width,
      height: height,
      animate: true,
    ).render(context);
  }

  String _hexToRgb(String hex) {
    hex = hex.replaceAll('#', '');
    final r = int.parse(hex.substring(0, 2), radix: 16) / 255.0;
    final g = int.parse(hex.substring(2, 4), radix: 16) / 255.0;
    final b = int.parse(hex.substring(4, 6), radix: 16) / 255.0;
    return '$r, $g, $b';
  }
}

/// Plasma effect shader
class PlasmaShader extends Widget {
  final Widget? child;
  final double? width;
  final double? height;
  final double speed;

  PlasmaShader({
    this.child,
    this.width,
    this.height,
    this.speed = 1.0,
  });

  @override
  String render(BuildContext context) {
    final shader = '''
      void main() {
        vec2 uv = gl_FragCoord.xy / resolution;
        float v1 = sin(uv.x * 10.0 + time * $speed);
        float v2 = sin(uv.y * 10.0 + time * $speed);
        float v3 = sin((uv.x + uv.y) * 10.0 + time * $speed);
        float v = (v1 + v2 + v3) / 3.0;
        vec3 color = vec3(
          sin(v * 3.14159) * 0.5 + 0.5,
          sin(v * 3.14159 + 2.0) * 0.5 + 0.5,
          sin(v * 3.14159 + 4.0) * 0.5 + 0.5
        );
        gl_FragColor = vec4(color, 1.0);
      }
    ''';

    return ShaderWidget(
      child: child,
      fragmentShader: shader,
      width: width,
      height: height,
      animate: true,
    ).render(context);
  }
}

/// Glow effect shader
class GlowShader extends Widget {
  final Widget? child;
  final String color;
  final double? width;
  final double? height;
  final double intensity;
  final bool pulse;

  GlowShader({
    this.child,
    this.color = '#00ff00',
    this.width,
    this.height,
    this.intensity = 1.0,
    this.pulse = false,
  });

  @override
  String render(BuildContext context) {
    final shader = '''
      void main() {
        vec2 uv = gl_FragCoord.xy / resolution;
        vec2 FDCenter = vec2(0.5);
        float dist = distance(uv, FDCenter);
        float glow = exp(-dist * 5.0) * $intensity;
        ${pulse ? 'glow *= (sin(time * 2.0) * 0.5 + 0.5);' : ''}
        vec3 color = vec3(${_hexToRgb(color)});
        gl_FragColor = vec4(color * glow, glow);
      }
    ''';

    return ShaderWidget(
      child: child,
      fragmentShader: shader,
      width: width,
      height: height,
      animate: pulse,
    ).render(context);
  }

  String _hexToRgb(String hex) {
    hex = hex.replaceAll('#', '');
    final r = int.parse(hex.substring(0, 2), radix: 16) / 255.0;
    final g = int.parse(hex.substring(2, 4), radix: 16) / 255.0;
    final b = int.parse(hex.substring(4, 6), radix: 16) / 255.0;
    return '$r, $g, $b';
  }
}

/// Noise/grain shader
class NoiseShader extends Widget {
  final Widget? child;
  final double? width;
  final double? height;
  final double intensity;
  final bool animate;

  NoiseShader({
    this.child,
    this.width,
    this.height,
    this.intensity = 0.5,
    this.animate = false,
  });

  @override
  String render(BuildContext context) {
    final shader = '''
      float random(vec2 st) {
        return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
      }
      
      void main() {
        vec2 uv = gl_FragCoord.xy / resolution;
        float noise = random(uv ${animate ? '+ time' : ''}) * $intensity;
        gl_FragColor = vec4(vec3(noise), 1.0);
      }
    ''';

    return ShaderWidget(
      child: child,
      fragmentShader: shader,
      width: width,
      height: height,
      animate: animate,
    ).render(context);
  }
}



