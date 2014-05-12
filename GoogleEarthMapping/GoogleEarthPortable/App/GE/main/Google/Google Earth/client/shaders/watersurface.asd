/////////////////////////
// Copyright 2008 Google Inc. All Rights Reserved.
/////////////////////////

/////////////////////////
//  INTERFACE
//
//  Used in the modeling tool for this shader.
/////////////////////////
[INTERFACE]
section=watersurface

[watersurface]
attrs=


/////////////////////////
//  CONFIGURATION
//
//  This section links this shader with an external
// configuration (.cfg) file.  It als sets the
//  default implementation.
/////////////////////////
[CONFIGURATION]
//  The configuration file used to customize
//  this shader for different platforms.
fileName=watersurface.cfg

//  The default implementation that will be used if
//  one is not specified in the configuration file.
//  This implementation can be overridden in textured.cfg
implementation=hardware_shader_implementation


/////////////////////////
//  IMPLEMENTATION
//
//  This section defines each of the implementations
// of this shader.  Each implementation must
//  declare the passes that it will be using, its
// shader processor, and whether or not to use a
//  render package for the shader.
/////////////////////////
[hardware_shader_implementation]
passes=single_pass
//  Use the default processor.
processor=defaultProcessor
//  Single-pass shaders do not need to use
//  render packages.
useRenderPackage = false

/////////////////////////
//  PASS DECLARATIONS
//
//  This section defines that attributes that will be pushed during
//  each pass of the shader.  The [CONFIGURATION] section defines
//  which of these passes will be used by the shader.
/////////////////////////
[single_pass]
attrs=enableVertexShader,bindVertexShader,enablePixelShader,bindPixelShader

/////////////////////////
// PROCESSORS
//
//  Below are the definitions of each of the shader processors
//  used by this shader.
/////////////////////////
[defaultProcessor]
//  This shader does not use a custom processor, so
//  just use igShaderProcessor.  igShaderProcessor can
//  be replaced with any class derived from
//  igShaderProcessor.
type=igShaderProcessor

/////////////////////////
//  ATTRIBUTES
//
//  Below are definitions of all the attributes used by the shader.
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
_textDefinition.file=watersurface.arbvp1
_entryPoint.value=vmain
_stateList.value = model_view_proj_VS, fog_density_VS,\
    eye_pos_and_anim_time_VS, clip_to_water_mat_VS, wave_scales_VS
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
_textDefinition.file=watersurface.arbfp1
_entryPoint.value=pmain
_stateList.value = fog_color_and_max_alpha_PS, bump_weights_PS,\
    fragment_constants_PS
_samplerList.value = bump_map_PS, sky_reflection_map_PS
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
_parameterName.value = model_view_proj
// Matrices are composed of four vectors.
_elementSize.value = 4
// Each vector in the matrix has four elements.
_vectorWidth.value = 4
const = false

// X: density used in fog exp2 function.
[fog_density_VS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = water_to_sun
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 23
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

// XYZ: eye position in water coordinates.
// W: animation time that wraps between 0 and 1.
[eye_pos_and_anim_time_VS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = eye_pos_and_anim_time
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 24
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

// Matrix from world to a water coordinate system where we can apply
// bump mapping. The water coordinate system's origin is in the center of
// the planet and is the same across all water tiles rendered in the current
// frame.
[clip_to_water_mat_VS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.matrices.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = clip_to_water_mat
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 25
// Matrices are composed of four vectors.
_elementSize.value = 4
// Each vector in the matrix has four elements.
_vectorWidth.value = 4
const = false

// Scale of waves at each visible level.
// Bigger values correspond to more (and smaller) waves.
[wave_scales_VS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = eye_pos_and_anim_time
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 29
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

// XYZ: fog color
// W: current frame's maximum alpha.
[fog_color_and_max_alpha_PS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _parameterName, _elementIndex, _elementSize,\
  _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// _parameterName applies only for higher level languages such as Cg or HLSL.
_parameterName.value = max_alpha_bias
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 26
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

// Weights of bump map samples at each visible level.
[bump_weights_PS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _elementIndex, _elementSize, _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 27
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

// X: 2 / sum_of_elements(bump_weights).
[fragment_constants_PS]
type = igGfxShaderConstant
fields = _name, _baseRegister, _elementIndex, _elementSize, _vectorWidth
_name.value = generic.vectors.value
// The base registry depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_baseRegister.value = -1
// The element index is an identifier that allows us to modify this attribute
// during run-time.
_elementIndex.value = 28
// Single vector.
_elementSize.value = 1
// Vector with four elements.
_vectorWidth.value = 4
const = false

/////////////////////////
// Shader samplers.
/////////////////////////
[bump_map_PS]
fields = _name, _samplerNumber, _textureUnit
type=igTextureSamplerSource
_name.value = bump_map
// The sampler number depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_samplerNumber.value = -1
// User texture stage number.
_textureUnit.value = 0
const = false

[sky_reflection_map_PS]
fields = _name, _samplerNumber, _textureUnit
type=igTextureSamplerSource
_name.value = sky_reflection_map
// The sampler number depends on the shader source code, which
// depends on the target configuration. Therefore, _baseRegister
// is overwritten inside the .cfg file.
_samplerNumber.value = -1
// User texture stage number.
_textureUnit.value = 1
const = false
