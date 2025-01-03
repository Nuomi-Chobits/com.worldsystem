


using System;

namespace AmplifyShaderEditor
{
	[Serializable]
	[NodeAttributes( 
#if !WB_LANGUAGE_CHINESE
"Face"
#else
"面对"
#endif
,            /*<!C>*/
#if !WB_LANGUAGE_CHINESE
"Primitive"
#else
"原始"
#endif
/*<C!>*/, 
#if !WB_LANGUAGE_CHINESE
"Indicates whether the rendered surface is facing the camera (1), or facing away from the camera (0)"
#else
"指示渲染曲面是面向摄影机（1）还是背向摄影机（0）"
#endif
)]
	public class FaceVariableNode : ParentNode
	{
		public const string FaceOnVertexWarning = "Face type nodes generates extra instructions when used on vertex ports since it needs to manually calculate the value";

		protected override void CommonInit( int uniqueId )
		{
			base.CommonInit( uniqueId );
			AddOutputPort( WirePortDataType.FLOAT, "Out" );
			m_previewShaderGUID = "4b0b5b9f16353b840a5f5ad2baab3c3c";
		}

		public override string GenerateShaderForOutput( int outputId, ref MasterNodeDataCollector dataCollector, bool ignoreLocalvar )
		{
			if ( dataCollector.PortCategory == MasterNodePortCategory.Tessellation )
			{
				UIUtils.ShowMessage( UniqueId, m_nodeAttribs.Name + " node does not work on Tessellation port" );
				return m_outputPorts[0].ErrorValue;
			}

			if ( dataCollector.PortCategory == MasterNodePortCategory.Vertex )
			{
				if( dataCollector.TesselationActive )
				{
					UIUtils.ShowMessage( UniqueId , m_nodeAttribs.Name + " node does not work properly on Tessellation ports" );
					return m_outputPorts[ 0 ].ErrorValue;
				}
				else
				{
					UIUtils.ShowMessage( UniqueId , FaceOnVertexWarning, MessageSeverity.Warning );
					string faceVariable = GeneratorUtils.GenerateVertexFace( ref dataCollector , UniqueId );
					return faceVariable;
				}
			}

			if ( dataCollector.IsTemplate )
			{
				return dataCollector.TemplateDataCollectorInstance.GetVFace( UniqueId );
			}
			else
			{
				if ( dataCollector.CurrentCanvasMode == NodeAvailability.TemplateShader )
				{
					dataCollector.AddToInput( UniqueId, SurfaceInputs.FRONT_FACING );
				}
				else
				{
					dataCollector.AddToInput( UniqueId, SurfaceInputs.FRONT_FACING_VFACE );
				}

				string variable = ( dataCollector.PortCategory == MasterNodePortCategory.Vertex ) ? Constants.VertexShaderOutputStr : Constants.InputVarStr;
				return variable + "." + Constants.IsFrontFacingVariable;
			}
		}
	}
}
