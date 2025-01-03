using UnityEngine;
using UnityEditor;

using System;
namespace AmplifyShaderEditor
{
	[Serializable]
	[NodeAttributes( 
#if !WB_LANGUAGE_CHINESE
"Parallax Mapping"
#else
"视差映射"
#endif
,            /*<!C>*/
#if !WB_LANGUAGE_CHINESE
"UV Coordinates"
#else
"UV坐标"
#endif
/*<C!>*/, 
#if !WB_LANGUAGE_CHINESE
"Calculates offseted UVs for parallax mapping"
#else
"计算用于视差贴图的偏移UV"
#endif
)]
	public sealed class ParallaxMappingNode : ParentNode
	{
		private enum ParallaxType { Normal, Planar }

		[SerializeField]
		private int m_selectedParallaxTypeInt = 0;

		[SerializeField]
		private ParallaxType m_selectedParallaxType = ParallaxType.Normal;

		private readonly string[] m_parallaxTypeStr = { "Normal", "Planar" };

		private int m_cachedPropertyId = -1;

		private UpperLeftWidgetHelper m_upperLeftWidget = new UpperLeftWidgetHelper();

		protected override void CommonInit( int uniqueId )
		{
			base.CommonInit( uniqueId );
			AddInputPort( WirePortDataType.FLOAT2, false, "UV" );
			AddInputPort( WirePortDataType.FLOAT, false, 
#if !WB_LANGUAGE_CHINESE
"Height"
#else
"身高"
#endif
);
			AddInputPort( WirePortDataType.FLOAT, false, 
#if !WB_LANGUAGE_CHINESE
"Scale"
#else
"规模"
#endif
);
			AddInputPort( WirePortDataType.FLOAT3, false, 
#if !WB_LANGUAGE_CHINESE
"ViewDir (tan)"
#else
"ViewDir（棕褐色）"
#endif
);
			AddOutputPort( WirePortDataType.FLOAT2, "Out" );
			m_useInternalPortData = true;
			m_autoDrawInternalPortData = true;
			m_autoWrapProperties = true;
			m_textLabelWidth = 105;
			UpdateTitle();
			m_forceDrawPreviewAsPlane = true;
			m_hasLeftDropdown = true;
			m_previewShaderGUID = "589f12f68e00ac74286815aa56053fcc";
		}

		public override void Destroy()
		{
			base.Destroy();
			m_upperLeftWidget = null;
		}

		public override void SetPreviewInputs()
		{
			base.SetPreviewInputs();

			if( m_cachedPropertyId == -1 )
				m_cachedPropertyId = Shader.PropertyToID( "_ParallaxType" );

			PreviewMaterial.SetFloat( m_cachedPropertyId, ( m_selectedParallaxType == ParallaxType.Normal ? 0 : 1 ) );
		}

		public override string GenerateShaderForOutput( int outputId, ref MasterNodeDataCollector dataCollector, bool ignoreLocalvar )
		{
			base.GenerateShaderForOutput( outputId, ref dataCollector, ignoreLocalvar );

			string textcoords = m_inputPorts[ 0 ].GeneratePortInstructions( ref dataCollector );
			string height = m_inputPorts[ 1 ].GeneratePortInstructions( ref dataCollector );
			string scale = m_inputPorts[ 2 ].GeneratePortInstructions( ref dataCollector );
			string viewDirTan = m_inputPorts[ 3 ].GeneratePortInstructions( ref dataCollector );
			string localVarName = "Offset" + OutputId;
			string calculation = "";

			switch( m_selectedParallaxType )
			{
				default:
				case ParallaxType.Normal:
				calculation = "( ( " + height + " - 1 ) * " + viewDirTan + ".xy * " + scale + " ) + " + textcoords;
				break;
				case ParallaxType.Planar:
				calculation = "( ( " + height + " - 1 ) * ( " + viewDirTan + ".xy / " + viewDirTan + ".z ) * " + scale + " ) + " + textcoords;
				break;
			}

			dataCollector.AddLocalVariable( UniqueId, CurrentPrecisionType, m_outputPorts[ 0 ].DataType, localVarName, calculation );
			
			return GetOutputVectorItem( 0, outputId, localVarName );
		}

		public override void Draw( DrawInfo drawInfo )
		{
			base.Draw( drawInfo );
			EditorGUI.BeginChangeCheck();
			m_selectedParallaxTypeInt = m_upperLeftWidget.DrawWidget( this, m_selectedParallaxTypeInt, m_parallaxTypeStr );
			if( EditorGUI.EndChangeCheck() )
			{
				switch( m_selectedParallaxTypeInt )
				{
					default:
					case 0: m_selectedParallaxType = ParallaxType.Normal; break;
					case 1: m_selectedParallaxType = ParallaxType.Planar; break;
				}
				UpdateTitle();
			}
		}

		public override void DrawProperties()
		{
			base.DrawProperties();
			
			EditorGUI.BeginChangeCheck();
			m_selectedParallaxTypeInt = EditorGUILayoutPopup( 
#if !WB_LANGUAGE_CHINESE
"Parallax Type"
#else
"视差类型"
#endif
, m_selectedParallaxTypeInt, m_parallaxTypeStr );
			if( EditorGUI.EndChangeCheck() )
			{
				switch( m_selectedParallaxTypeInt )
				{
					default:
					case 0: m_selectedParallaxType = ParallaxType.Normal; break;
					case 1: m_selectedParallaxType = ParallaxType.Planar; break;
				}
				UpdateTitle();
			}

			EditorGUILayout.HelpBox( 
#if !WB_LANGUAGE_CHINESE
"Normal type does a cheaper approximation thats view dependent while Planar is more accurate but generates higher aliasing artifacts at steep angles."
#else
"法线类型做了一个更便宜的近似，它依赖于视图，而平面类型更准确，但在陡峭的角度会产生更高的混叠伪影。"
#endif
, MessageType.None );
		}


		void UpdateTitle()
		{
			m_additionalContent.text = string.Format( Constants.SubTitleTypeFormatStr, m_parallaxTypeStr[ m_selectedParallaxTypeInt ] );
		}

		public override void ReadFromString( ref string[] nodeParams )
		{
			base.ReadFromString( ref nodeParams );
			m_selectedParallaxType = (ParallaxType)Enum.Parse( typeof( ParallaxType ), GetCurrentParam( ref nodeParams ) );
			switch( m_selectedParallaxType )
			{
				default:
				case ParallaxType.Normal: m_selectedParallaxTypeInt = 0; break;
				case ParallaxType.Planar: m_selectedParallaxTypeInt = 1; break;
			}
			UpdateTitle();
		}

		public override void WriteToString( ref string nodeInfo, ref string connectionsInfo )
		{
			base.WriteToString( ref nodeInfo, ref connectionsInfo );
			IOUtils.AddFieldValueToString( ref nodeInfo, m_selectedParallaxType );
		}
	}
}
