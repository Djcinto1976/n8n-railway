import sys
import json
import logging
from typing import Dict, Any
from datetime import datetime
from services.document_processor import DocumentProcessor, EmailAttachment

# Configuração do logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('logs/document_processor.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

def process_n8n_request(request: Dict[str, Any]) -> Dict[str, Any]:
    """
    Processa uma requisição do n8n e retorna o resultado formatado
    """
    try:
        # Validação dos campos obrigatórios
        if 'content' not in request:
            raise ValueError("Campo 'content' é obrigatório")

        # Extração dos campos com valores padrão
        content = request.get('content', '')
        filename = request.get('filename', 'documento.pdf')
        content_type = request.get('content_type', 'application/pdf')
        origem = request.get('origem', 'n8n')
        remetente = request.get('remetente', 'n8n_workflow')

        # Log da requisição
        logger.info(f"Processando documento: {filename} de {remetente}")

        # Criação do objeto de anexo
        attachment = EmailAttachment(
            nome=filename,
            content_type=content_type,
            content=content.encode('utf-8'),
            origem=origem,
            remetente=remetente
        )

        # Processamento do documento
        processor = DocumentProcessor()
        resultado = processor.process(attachment)

        # Adiciona metadados ao resultado
        resultado.update({
            'processado_em': datetime.now().isoformat(),
            'nome_arquivo': filename,
            'origem': origem,
            'remetente': remetente,
            'status': 'sucesso'
        })

        logger.info(f"Documento processado com sucesso: {filename}")
        return resultado

    except ValueError as e:
        logger.error(f"Erro de validação: {str(e)}")
        return {
            'status': 'erro',
            'tipo_erro': 'validacao',
            'mensagem': str(e),
            'timestamp': datetime.now().isoformat()
        }
    except Exception as e:
        logger.error(f"Erro ao processar documento: {str(e)}", exc_info=True)
        return {
            'status': 'erro',
            'tipo_erro': 'processamento',
            'mensagem': str(e),
            'timestamp': datetime.now().isoformat()
        }

def main():
    """
    Função principal que processa entrada STDIN do n8n
    """
    logger.info("Iniciando processador de documentos MCP")

    while True:
        try:
            # Lê uma linha da entrada padrão
            line = sys.stdin.readline()
            if not line:
                break

            # Processa a requisição JSON
            request = json.loads(line)
            resultado = process_n8n_request(request)

            # Envia resposta formatada
            response = json.dumps(resultado, default=str, ensure_ascii=False)
            sys.stdout.write(response + "\n")
            sys.stdout.flush()

        except json.JSONDecodeError as e:
            logger.error(f"Erro ao decodificar JSON: {str(e)}")
            sys.stdout.write(json.dumps({
                'status': 'erro',
                'tipo_erro': 'json_invalido',
                'mensagem': 'JSON inválido na entrada',
                'timestamp': datetime.now().isoformat()
            }) + "\n")
            sys.stdout.flush()
        except Exception as e:
            logger.error(f"Erro inesperado: {str(e)}", exc_info=True)
            sys.stdout.write(json.dumps({
                'status': 'erro',
                'tipo_erro': 'sistema',
                'mensagem': 'Erro interno do sistema',
                'timestamp': datetime.now().isoformat()
            }) + "\n")
            sys.stdout.flush()

if __name__ == "__main__":
    main()
