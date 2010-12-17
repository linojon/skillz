module MessageLogger
  def log_message( msg, log_to_console=false )
    #debugger
    logger.info("******** #{Time.now} #{caller[0]}: " + msg)
    puts( msg) if log_to_console
  end
end
