# frozen_string_literal: true

require "mail"
require "active_support/all"

class JSONLExporter

  def export
    data = []
    Dir.glob("data/*.txt").each do |file_path|
      #begin
        mail = Mail.new(File.read(file_path).force_encoding("utf-8").encode("utf-8").b)
        content = if mail.multipart?
                    mail.html_part.try(:decoded)
                  else
                    mail.body.try(:decoded)
                  end
        receivers = mail.to.is_a?(Array) ? mail.to : [mail.to]
        cc = mail.cc.is_a?(Array) ? mail.cc : [mail.cc]
        receivers = receivers.compact.concat(cc.compact)
        content = content.try(:slice, 0, 1000)
        if content
          content = content.force_encoding("utf-8").encode("utf-8")
        end
        data.push({
          category: "spam",
          sender: mail.from.try(:first),
          receivers: receivers,
          subject: nil,
          content: nil
        })
      #rescue
        #puts " - Failed #{file_path}"
      #end
    end

    File.write("output/spam.jsonl", data.to_json)
  end
end

JSONLExporter.new.export
