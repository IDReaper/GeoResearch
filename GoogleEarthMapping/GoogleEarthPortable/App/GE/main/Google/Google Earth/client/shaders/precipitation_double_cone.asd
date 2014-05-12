/////////////////////////
// Copyright 2008 Google Inc. All Rights Reserved.
/////////////////////////

/////////////////////////
//	INTERFACE
//
//	Used in the modeling tool for this shader.
/////////////////////////
[INTERFACE]
section=precipitation_double_cone

[precipitation_double_cone]
attrs=


/////////////////////////
//	CONFIGURATION
//
//	This section links this shader with an external
// configuration (.cfg) file.  It als sets the
//	default implementation.
/////////////////////////
[CONFIGURATION]
//	The configuration file used to customize
//	this shader for different platforms.
fileName=precipitation_double_cone.cfg

//	The default implementation that will be used if
//	one is not specified in the configuration file.
//	This implementation can be overridden in textured.cfg
implementation=hardware_shader_implementation


/////////////////////////
//	IMPLEMENTATION
//
//	This section defines each of the implementations
// of this shader.  Each implementation must
//	declare the passes that it will be using, its
// shader processor, and whether or not to use a
//	render package for the shader.
/////////////////////////
[hardware_shader_implementation]
passes=single_pass
//	Use the default processor.
processor=defaultProcessor
//	Single-pass shaders do not need to use
//	render packages.
useRenderPackage = false

/////////////////////////
//	PASS DECLARATIONS
//
//	This section defines that attributes that will be pushed during
//	each pass of the shader.  The [CONFIGURATION] section defines
//	which of these passes will be used by the shader.
/////////////////////////
[single_pass]
attrs=enableVertexShader,bindVertexShader,enablePixelShader,bindPixelShader

/////////////////////////
// PROCESSORS
//
//	Below are the definitions of each of the shader processors
//	used by this shader.
/////////////////////////
[defaultProcessor]
//	This shader does not use a custom processor, so
//	just use igShaderProcessor.  igShaderProcessor can
//	be replaced with any class derived from
//	igShaderProcessor.
type=igShaderProcessor

/////////////////////////
//	ATTRIBUTES
//
//	Below are definitions of all the attributes used by the shader.
/////////////////////////

/////////////////////////
// Vertex Shader
/////////////////////////
[enableVertexShader]
type=igVertexPipelineModeAttr
fields=_mode
_mode.value=IG_GFX_VERTEX_PIPELINE_MODE_SHADER
const = false

[bindVertexShader]
type=igVertexShaderBindAttr
fields=_vertexShader
// object values can refer to another section.
_vertexShader.value=vertexShader
const = false

[vertexShader]
type=igVertexShaderAttr
fields=_textDefinition,_entryPoint,_stateList
// File containing shader program. Default to ARB version.
_textDefinition.file=precipitation_double_cone.arbvp1
_entryPoint.value=vmain
_stateList.value = model_view_proj_VS, vertex_args_VS
const = false

/////////////////////////
// Pixel Shader
/////////////////////////
[enablePixelShader]
type=igPixelPipelineModeAttr
fields=_pipelineMode
_pipelineMode.value=IG_GFX_PIXEL_PIPELINE_MODE_SHADER
const = false

[bindPixelShader]
type=igPixelShaderBindAttr
fields=_pixelShader
// object values can refer to another section.
_pixelShader.value=pixelShader
const = false

[pixelShader]
type=igPixelShaderAttr
fields=_textDefinition,_entryPoint,_stateList,_samplerList
// File containing shader program. Default to ARB version.
_textDefinition.file=precipitation_double_cone.arbfp1
_entryPoint.value=pmain
_stateList.value=pixel_args_PS, time_scrolls_PS
_samplerList.value = texture0_PS, texture1_PS, texture2_PS, texture3_PS
const = false

/////////////////////////
// Shader constants (i.e. constant registers).
/////////////////////////
[model_view_proj_VS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementSize, _vectorWidth
_name.value = matrix.mvp
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = modelViewProj
// Matrices are composed of four vectors.
_elementSize.value = 4
// Each vector in the matrix has four elements.
_vectorWidth.value = 4
const = false

// x: texture elongation factor
// yzw: unused
[vertex_args_VS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = vertexArgs
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 32
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

// x: time in seconds
// y: time-based opacity (for transitions - same value as VS)
// z: precipitation intensity opacity
// w: unused
[pixel_args_PS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = pixelArgs
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 31
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

// xyzw:  the scroll shift with respect to time of the texture coordinates
[time_scrolls_PS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = time_scrolls
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 33
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

/////////////////////////
// Shader samplers.
/////////////////////////
[texture0_PS]
fields = _name, _samplerNumber, _textureUnit
type=igTextureSamplerSource
_name.value=groundTexture
// The sampler number depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_samplerNumber.value = -1
// User texture stage number.
_textureUnit.value = 0
const = false

[texture1_PS]
fields = _name, _samplerNumber, _textureUnit
type=igTextureSamplerSource
_name.value=groundTexture
// The sampler number depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_samplerNumber.value = -1
// User texture stage number.
_textureUnit.value = 1
const = false

[texture2_PS]
fields = _name, _samplerNumber, _textureUnit
type=igTextureSamplerSource
_name.value=groundTexture
// The sampler number depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_samplerNumber.value = -1
// User texture stage number.
_textureUnit.value = 2
const = false

[texture3_PS]
fields = _name, _samplerNumber, _textureUnit
type=igTextureSamplerSource
_name.value=groundTexture
// The sampler number depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_samplerNumber.value = -1
// User texture stage number.
_textureUnit.value = 3
const = false
